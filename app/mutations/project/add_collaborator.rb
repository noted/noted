class Project
  class AddCollaborator < Mutations::Command
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

      u = User.find(collaborator[:id])

      p.collaborator_ids << u.id.to_s
      p.updater = u

      p.save
    end
  end
end
