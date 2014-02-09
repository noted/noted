class ProjectCreate < Mutations::Command
  required do
    model :current_user, class: User
    hash  :project do
      string :title
      string :summary, empty: true, nils: true
    end
  end

  def execute
    p = Project.new(self.project)
    p.user = current_user

    p.collaborator_ids << current_user.id

    p.save

    return p
  end
end
