module Scholar

  # The basis for sources. Inherit from this class to create
  # other types of sources.
  class Source < Utilities
    class << self

      # Defines the order of attributes for Sources.
      #
      # ==== Attributes
      #
      # * +arr+ - Array of Symbols (keys). This is the order the hash's key
      #   will be in.
      def sequence(arr = nil)
        unless arr.nil?
          @@sequence = arr
        end

        self.descendants.empty? ? @@sequence : nil
      end

      # Defines what actions need to be taken on the attributes.
      #
      # ==== Attributes
      #
      # * +block+ - A block of +rule+ definitions. The rule definition should
      #   call a method in Scholar::Utilities::Formatters.
      #
      # ==== Example
      #
      #   rules do
      #     rule(:foo) {|v| italicize(v) }
      #   end
      def rules(&block)
        if block
          @@rules ||= []

          self.class_eval(&block)
        else
          self.descendants.empty? ? @@rules : nil
        end
      end

      # Defines a specific action to be taken on an attribute.
      #
      # ==== Attributes
      #
      # * +key+ - The key of the hash to take the action on. Symbol.
      # * +action+ - The action to take on the key. Should be a method within
      #   Scholar::Utilities::Formatters.
      def rule(key, &action)
        @@rules << [key, action]
      end
    end
  end

  # A collection of different source types.
  module Sources
  end

  Dir[File.dirname(__FILE__) + '/sources/*.rb'].each {|file| require file }
end
