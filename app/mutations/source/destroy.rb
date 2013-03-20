class Source
  class Destroy < Mutations::Command
    required do
      model :source, class: BSON::ObjectId
      model :author, class: BSON::ObjectId
    end

    def execute
      s = Source.find(source)

      s.project.updater = User.find(author)

      s.destroy
    end
  end
end
