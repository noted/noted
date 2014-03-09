class NoteDestroy < Mutations::Command
  required do
    model :current_user, class: User
    hash  :note do
      string :id
    end
  end

  def execute
    n = Note.find(self.note['id'])

    return add_error(:current_user, :unauthorized, 'not authorized') unless current_user.can_destroy?(n)

    n.updater = current_user

    n.project.updater = current_user
    n.project.updated_at = Time.now

    n.destroy

    return nil
  end
end
