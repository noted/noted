module Scholar

  # Generic utilities.
  class Utilities

    # A list of Contributors.
    class ContributorList

      # An Array of Contributors.
      attr_reader :contributors

      # The names in MLA format.
      attr_reader :names

      # Create a list of Contributors.
      #
      # ==== Attributes
      #
      # * +contributors+ - An Array of Contributors or an Array of Hashes.
      # * +role+ - Either +:author:+ or +:nonauthor+.
      #
      # ==== Examples
      #
      #   Scholar::Utilities::ContributorList.new([
      #     {
      #       :first => "Douglas",
      #       :last => "Adams"
      #     },
      #     {
      #       :first => "Eion",
      #       :last => "Colfer"
      #     }
      #   ])
      def initialize(contributors, role = :nonauthor)
        @names = ""

        contributors.each do |c|
          if c.is_a?(Hash)
            contributors[contributors.index(c)] = Contributor.new(c)
          end
        end

        contributors.each do |c|
          if contributors.index(c) == 0 && role == :author
            c.reorder!(:last)
          else
            c.reorder!(:first)
          end

          @names << c.name

          unless contributors.last == c
            @names << ", "
          end
        end

        @contributors = contributors
        @role = role

        return self
      end
    end
  end
end
