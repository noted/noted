class ProjectUpdate < NotedMutation
  required do
    model :current_user, class: User
    hash  :project do
      string :id
      string :title
      string :summary, empty: true, nils: true
      string :citation_style_id
    end
  end

  def execute
    p = Project.find(self.project['id'])

    return add_error(:current_user, :unauthorized, 'not authorized') unless current_user.can_update?(p)

    p.update_attributes(self.project)

    p.updater = current_user

    p.save

    mongoid_errors!(p)

    ActionController::Base.new.expire_fragment(p)

    return p
  end
end
