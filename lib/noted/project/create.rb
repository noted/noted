class ProjectCreate < Mutations::Command
  required do
    model :current_user, class: User
    hash  :project do
      string :title
    end
  end

  def execute
    p = Project.new(self.project)
    p.user = current_user
    p.save

    return p
  end
end
