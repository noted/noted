class Source
  class Destroy < Mutations::Command
    required do
      hash :source do
        model :id, class: BSON::ObjectId
        model :author, class: BSON::ObjectId
      end
    end

    def execute
      s = Source.find(source[:id])

      s.project.updater = User.find(source[:author])

      s.destroy
    end
  end
end
