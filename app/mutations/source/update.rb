class Source
  class Update < Mutations::Command
    required do
      string :author

      hash :source do
        string :id

        model :attributes, class: Hash
      end
    end

    def execute
      s = Source.find(source[:id])

      s.update_attributes(
        :citation => Scholar::Citation.new(source[:attributes]),
      )

      a = User.find(author)

      s.updater = a
      s.project.updater = a

      s.save

      s
    end
  end
end
