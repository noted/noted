class ProjectCreate < Mutations::Command
  required do
    model :current_user, class: User
    hash  :project do
      string :title
      string :summary, empty: true, nils: true
      string :citation_style_id, empty: true, nils: true
    end
  end

  def execute
    p = Project.new(project)
    p.owner = current_user

    p.users << current_user

    p.creator = current_user
    p.updater = current_user

    p.save

    return p
  end
end
