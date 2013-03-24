class Source
  class Destroy < Mutations::Command
    required do
      model :author, class: BSON::ObjectId

      hash :source do
        model :id, class: BSON::ObjectId
      end
    end

    def execute
      s = Source.find(source[:id])

      s.project.updater = User.find(author)

      s.destroy
    end
  end
end
