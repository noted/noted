module Scholar

  # Generic utilities.
  class Utilities

    # A person associated with a work.
    class Contributor

      # The data associated with the person.
      attr_reader :attributes

      # The name in the correct format.
      attr_reader :name

      # Create a Contributor.
      #
      # ==== Attributes
      #
      # * +data+ - The data associated with the Contributor.
      # * +order+ - Last-name first (+:last+) or first-name first (+:first+).
      #
      # ==== Options
      #
      # * +:first+ - The name of the Contributor.
      # * +:middle+ - The middle name of the Contributor.
      #   Will be shortened to an initial.
      # * +:last+ - The surname of the Contributor.
      # * +:suffix+ - The suffix of the Contributor (PhD, Esq, etc).
      #
      # ==== Examples
      #
      #   Scholar::Utilities::Contributor.new({
      #     :first => "Douglas",
      #     :last => "Adams"
      #   })
      def initialize(data, order = :first)
        if data.is_a?(String)
          data = hash!(data)

          data[:role] = :author
        end

        data.delete_if {|k, v| v.nil? || v.empty? }

        @order = order

        @attributes = order!(data)
        @name = name!(@attributes)
      end

      # Reorders the name of the Contributor with the given order.
      #
      # ==== Attributes
      #
      # * +order+ - Either +:first+ or +:last+ name first.
      def reorder!(order)
        @order = order

        @attributes = order!(@attributes, order)
        @name = name!(@attributes)

        if @name[-2, 2] == ".," # Fix this.
          @name = @name[0..-3]
        end

        self
      end

      private

      # Make a Hash out of a String.
      def hash!(str)
        data = str.split(" ")

        result = Hash.new

        result[:first] = data.first

        result[:last] = data.last

        if data[2]
          result[:middle] = data[1]
        end

        result
      end

      # Order according to the sequence.
      def order!(hash, method = @order)
        if method == :last
          sequence = [:role, :last, :first, :middle, :suffix]
        else
          sequence = [:role, :first, :middle, :last, :suffix]
        end

        ordered = Scholar::Utilities.order!(hash, sequence)
      end

      # Generate the name with the given hash.
      def name!(attributes)
        hash = attributes.clone

        [:role, :order].each do |k|
          hash.delete(k)
        end

        if hash[:first].length == 1
          hash[:first] = "#{hash[:first]}."
        end

        if hash[:middle]
          hash[:middle] = "#{hash[:middle][0,1].upcase}."
        end

        if @order == :last || hash[:suffix]
          hash[:last] = "#{hash[:last]},"
        end

        if @order == :last && hash[:middle]
          hash[:middle] = "#{hash[:middle]},"
        end

        hash.values.compact.reject(&:empty?).join(' ').squish
      end
    end
  end
end
