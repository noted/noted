class Source
  class Update < Mutations::Command
    required do
      model :author, class: BSON::ObjectId

      hash :source do
        model :id, class: BSON::ObjectId
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
