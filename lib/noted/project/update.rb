class ProjectUpdate < Mutations::Command
  required do
    model :current_user, class: User
    hash  :project do
      string :id
      string :title
      string :summary, empty: true, nils: true
      string :citation_style
    end
  end

  def execute
    p = Project.find(self.project['id'])

    add_error(:current_user, :unauthorized, 'not authorized') unless current_user.can_update?(p)

    p.update_attributes(self.project)
    p.save

    return p
  end
end
