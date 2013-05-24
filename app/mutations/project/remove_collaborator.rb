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

      u = User.find(collaborator[:id])
      u.collaboration_ids.delete(project[:id])
      u.save

      p
    end
  end
end
