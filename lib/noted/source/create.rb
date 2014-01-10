class SourceCreate < Mutations::Command
  required do
    model :current_user, class: User
    model :project
    hash  :source do
      model :information, class: Hash
    end
  end

  def execute
    s = Source.new(self.source)
    s.project = self.project

    add_error(:current_user, :unauthorized, 'not authorized') unless current_user.can_create?(s)

    s.save

    return s
  end
end
