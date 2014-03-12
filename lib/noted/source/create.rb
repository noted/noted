class SourceCreate < Mutations::Command
  required do
    model :current_user, class: User
    model :project
    hash  :source do
      model :information, class: Hash
      string :tags
    end
  end

  def execute
    s = Source.new(self.source)
    s.project = self.project

    return add_error(:current_user, :unauthorized, 'not authorized') unless current_user.can_create?(s)

    s.creator = current_user
    s.updater = current_user

    s.save

    return s
  end
end
