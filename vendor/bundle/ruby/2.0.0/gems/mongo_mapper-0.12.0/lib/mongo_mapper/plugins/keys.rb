# encoding: UTF-8
require 'mongo_mapper/plugins/keys/key'

module MongoMapper
  module Plugins
    module Keys
      extend ActiveSupport::Concern

      included do
        extend ActiveSupport::DescendantsTracker
        key :_id, ObjectId, :default => lambda { BSON::ObjectId.new }
      end

      module ClassMethods
        def inherited(descendant)
          descendant.instance_variable_set(:@keys, keys.dup)
          super
        end

        def keys
          @keys ||= {}
        end

        def key(*args)
          Key.new(*args).tap do |key|
            keys[key.name] = key
            create_accessors_for(key)
            create_key_in_descendants(*args)
            create_indexes_for(key)
            create_validations_for(key)
          end
        end

        def key?(key)
          keys.keys.include?(key.to_s)
        end

        def using_object_id?
          object_id_key?(:_id)
        end

        def object_id_keys
          keys.keys.select { |key| keys[key].type == ObjectId }.map { |k| k.to_sym }
        end

        def object_id_key?(name)
          object_id_keys.include?(name.to_sym)
        end

        def to_mongo(instance)
          return nil if instance.nil?
          instance.to_mongo
        end

        def from_mongo(value)
          return nil if value.nil?
          value.is_a?(self) ? value : load(value)
        end

        # load is overridden in identity map to ensure same objects are loaded
        def load(attrs)
          return nil if attrs.nil?
          begin
            attrs['_type'].present? ? attrs['_type'].constantize : self
          rescue NameError
            self
          end.allocate.initialize_from_database(attrs)
        end

        private
          def key_accessors_module_defined?
            if method(:const_defined?).arity == 1 # Ruby 1.9 compat check
              const_defined?('MongoMapperKeys')
            else
              const_defined?('MongoMapperKeys', false)
            end
          end

          def accessors_module
            if key_accessors_module_defined?
              const_get 'MongoMapperKeys'
            else
              const_set 'MongoMapperKeys', Module.new
            end
          end

          def create_accessors_for(key)
            accessors_module.module_eval <<-end_eval
              def #{key.name}
                read_key(:#{key.name})
              end

              def #{key.name}_before_type_cast
                read_key_before_type_cast(:#{key.name})
              end

              def #{key.name}=(value)
                write_key(:#{key.name}, value)
              end

              def #{key.name}?
                read_key(:#{key.name}).present?
              end
            end_eval

            include accessors_module
          end

          def create_key_in_descendants(*args)
            descendants.each { |descendant| descendant.key(*args) }
          end

          def create_indexes_for(key)
            if key.options[:index] && !key.embeddable?
              warn "[DEPRECATION] :index option when defining key #{key.name.inspect} is deprecated. Put indexes in `db/indexes.rb`"
              ensure_index key.name
            end
          end

          def create_validations_for(key)
            attribute = key.name.to_sym

            if key.options[:required]
              if key.type == Boolean
                validates_inclusion_of attribute, :in => [true, false]
              else
                validates_presence_of(attribute)
              end
            end

            if key.options[:unique]
              validates_uniqueness_of(attribute)
            end

            if key.options[:numeric]
              number_options = key.type == Integer ? {:only_integer => true} : {}
              validates_numericality_of(attribute, number_options)
            end

            if key.options[:format]
              validates_format_of(attribute, :with => key.options[:format])
            end

            if key.options[:in]
              validates_inclusion_of(attribute, :in => key.options[:in])
            end

            if key.options[:not_in]
              validates_exclusion_of(attribute, :in => key.options[:not_in])
            end

            if key.options[:length]
              length_options = case key.options[:length]
              when Integer
                {:minimum => 0, :maximum => key.options[:length]}
              when Range
                {:within => key.options[:length]}
              when Hash
                key.options[:length]
              end
              validates_length_of(attribute, length_options)
            end
          end
      end

      def initialize(attrs={})
        @_new = true
        self.attributes = attrs
      end

      def initialize_from_database(attrs={})
        @_new = false
        load_from_database(attrs)
        self
      end

      def persisted?
        !new? && !destroyed?
      end

      def attributes=(attrs)
        return if attrs.blank?

        attrs.each_pair do |key, value|
          if respond_to?(:"#{key}=")
            self.send(:"#{key}=", value)
          else
            self[key] = value
          end
        end
      end

      def attributes
        HashWithIndifferentAccess.new.tap do |attrs|
          keys.select { |name,key| !self[key.name].nil? || key.type == ObjectId }.each do |name, key|
            value = key.set(self[key.name])
            attrs[name] = value
          end

          embedded_associations.each do |association|
            if documents = instance_variable_get(association.ivar)
              if association.is_a?(Associations::OneAssociation)
                attrs[association.name] = documents.to_mongo
              else
                attrs[association.name] = documents.map { |document| document.to_mongo }
              end
            end
          end
        end
      end
      alias :to_mongo :attributes

      def assign(attrs={})
        warn "[DEPRECATION] #assign is deprecated, use #attributes="
        self.attributes = attrs
      end

      def update_attributes(attrs={})
        self.attributes = attrs
        save
      end

      def update_attributes!(attrs={})
        self.attributes = attrs
        save!
      end

      def update_attribute(name, value)
        self.send(:"#{name}=", value)
        save(:validate => false)
      end

      def id
        _id
      end

      def id=(value)
        if self.class.using_object_id?
          value = ObjectId.to_mongo(value)
        end

        self[:_id] = value
      end

      def [](name)
        read_key(name)
      end

      def []=(name, value)
        ensure_key_exists(name)
        write_key(name, value)
      end

      def keys
        self.class.keys
      end

      def key_names
        keys.keys
      end

      def non_embedded_keys
        keys.values.select { |key| !key.embeddable? }
      end

      def embedded_keys
        keys.values.select { |key| key.embeddable? }
      end

      private
        def load_from_database(attrs)
          return if attrs.blank?
          attrs.each do |key, value|
            if respond_to?(:"#{key}=") && !self.class.key?(key)
              self.send(:"#{key}=", value)
            else
              self[key] = value
            end
          end
        end

        def ensure_key_exists(name)
          self.class.key(name) unless respond_to?("#{name}=")
        end

        def set_parent_document(key, value)
          if key.embeddable? && value.is_a?(key.type)
            value._parent_document = self
          end
        end

        def read_key(key_name)
          if key = keys[key_name.to_s]
            value = key.get(instance_variable_get(:"@#{key_name}"))
            set_parent_document(key, value)
            instance_variable_set(:"@#{key_name}", value)
          end
        end

        def read_key_before_type_cast(name)
          instance_variable_get(:"@#{name}_before_type_cast")
        end

        def write_key(name, value)
          key = keys[name.to_s]
          set_parent_document(key, value)
          instance_variable_set :"@#{name}_before_type_cast", value
          instance_variable_set :"@#{name}", key.set(value)
        end
    end
  end
end

