class Project
  class RemoveCollaborator < Mutations::Command
    required do
      hash :project do
        string :id
      end

      hash :collaborator do
        string :id
      end
    end

    def execute
      p = Project.find(project[:id])
      p.collaborator_ids.delete(collaborator[:id])
      p.save

      p
    end
  end
end
