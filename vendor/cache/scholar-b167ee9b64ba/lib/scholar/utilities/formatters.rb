module Scholar

  # Generic utilities.
  class Utilities

    # String formatters.
    module Formatters

      # Capitalize the first character of a String.
      def capitalize(str)
        str.to_s.capitalize
      end

      # Add carets (<>) around String.
      def carets(str)
        "&#60;#{str.to_s}&#62;"
      end

      # Add a colon to the end of a String.
      def colon(str)
        "#{str.to_s}:"
      end

      # Add a comma to the end of a String.
      def comma(str)
        "#{str.to_s},"
      end

      # Add <em> tags around a String to italicize it.
      def italicize(str)
        "<em>#{str.to_s}</em>"
      end

      # Return the ordinal form of an integer (1 turns into 1st, etc).
      def ordinal(int)
        ActiveSupport::Inflector.ordinalize(int.to_i)
      end

      # Add a period to the end of a String.
      def period(str)
        "#{str.to_s}."
      end

      # Wrap a String in quotes.
      def quotes(str)
        "&#8220;#{str.to_s}&#8221;"
      end

      # Replace with a String.
      def replace(str)
        str.to_s
      end

      # Add +<u>+ tags around a String to italicize it.
      def underline(str)
        "<u>#{str.to_s}</u>"
      end
    end
  end
end
