class SourceDestroy < Mutations::Command
  required do
    model :current_user, class: User
    hash  :source do
      string :id
    end
  end

  def execute
    s = Source.find(self.source['id'])

    return add_error(:current_user, :unauthorized, 'not authorized') unless current_user.can_destroy?(s)

    s.updater = current_user

    s.project.updater = current_user
    s.project.updated_at = Time.now

    s.destroy

    return nil
  end
end
