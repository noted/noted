class Project
  class Destroy < Mutations::Command
    required do
      hash :project do
        model :id, class: BSON::ObjectId
      end
    end

    def execute
      p = Project.find(project[:id]).destroy
    end
  end
end
