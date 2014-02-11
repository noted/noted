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
    p.owner = current_user

    p.users << current_user

    p.save

    return p
  end
end
