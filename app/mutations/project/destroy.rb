class Project
  class Destroy < Mutations::Command
    required do
      model :project, class: BSON::ObjectId
    end

    def execute
      p = Project.find(project)
      p.destroy
    end
  end
end
