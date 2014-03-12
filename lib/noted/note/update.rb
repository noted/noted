class NoteUpdate < Mutations::Command
  required do
    model :current_user, class: User
    hash  :note do
      string :id
      string :title
      string :text, empty: true, nils: true
      string :tags, empty: true, nils: true
    end
  end

  def execute
    n = Note.find(self.note['id'])

    return add_error(:current_user, :unauthorized, 'not authorized') unless current_user.can_update?(n)

    n.update_attributes(self.note)
    n.updater = current_user

    n.project.updater = current_user
    n.project.updated_at = Time.now

    n.save

    ActionController::Base.new.expire_fragment(n)

    return n
  end
end
