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

      unless p.collaborator_ids.include?(u.id.to_s) || p.user == u
        p.collaborator_ids << u.id.to_s
        p.updater = u
      end

      p.save

      p
    end
  end
end
