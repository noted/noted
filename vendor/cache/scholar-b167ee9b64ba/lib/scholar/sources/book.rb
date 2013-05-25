module Scholar
  module Sources

    # A normal book.
    class Book < Scholar::Source
      sequence [
        :authors,
        :title,
        :editors,
        :compilers,
        :translators,
        :edition,
        :volume,
        :city,
        :publisher,
        :year,
        :media,
        :series
      ]

      rules do
        rule(:authors)     {|v| period(v) }

        rule(:title)       {|v| italicize(v) }
        rule(:title)       {|v| period(v) }

        rule(:editors)     {|v| replace("Ed. #{v}") }
        rule(:editors)     {|v| period(v) }

        rule(:compilers)   {|v| replace("Comp. #{v}") }
        rule(:compilers)   {|v| period(v) }

        rule(:translators) {|v| replace("Trans. #{v}") }
        rule(:translators) {|v| period(v) }

        rule(:edition)     {|v| replace("#{ordinal(v)} ed") }
        rule(:edition)     {|v| period(v) }

        rule(:volume)      {|v| replace("Vol. #{v}") }
        rule(:volume)      {|v| period(v) }

        rule(:city)        {|v| colon(v) }

        rule(:publisher)   {|v| comma(v) }

        rule(:year)        {|v| period(v) }

        rule(:media)       {|v| capitalize(v) }
        rule(:media)       {|v| period(v) }

        rule(:series)      {|v| period(v) }
      end
    end
  end
end
