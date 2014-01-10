class NoteUpdate < Mutations::Command
  required do
    model :current_user, class: User
    hash  :note do
      string :id
      string :title
      string :text
    end
  end

  def execute
    n = Note.find(self.note['id'])

    add_error(:current_user, :unauthorized, 'not authorized') unless current_user.can_update?(n)

    n.update_attributes(self.note)
    n.save

    return n
  end
end
