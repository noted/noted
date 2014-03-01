class ProjectAddCollaborator < Mutations::Command
  required do
    model :current_user, class: User
    model :project
    hash :user do
      string :id
    end
  end

  def execute
    return add_error(:current_user, :unauthorized, 'not authorized') unless current_user.can_update?(project)

    u = User.find(self.user['id'])

    project.users << u
    project.save

    return project
  end
end
