class Note
  class Create < Mutations::Command
    required do
      model :project, class: BSON::ObjectId
      model :author, class: BSON::ObjectId
    end

    def execute
      p = Project.find(project)

      n = Note.new(
        :title => "Untitled"
      )

      p.notes << n

      n.save

      n
    end
  end
end
