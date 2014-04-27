class ProjectDestroy < NotedMutation
  required do
    model :current_user, class: User
    hash  :project do
      string :id
    end
  end

  def execute
    p = Project.find(self.project['id'])

    return add_error(:current_user, :unauthorized, 'not authorized') unless current_user.can_update?(p)

    p.updater = current_user

    p.destroy

    mongoid_errors!(p)

    return nil
  end
end
