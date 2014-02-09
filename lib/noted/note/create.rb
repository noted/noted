class NoteCreate < Mutations::Command
  required do
    model :current_user, class: User
    model :project
    hash  :note do
      string :title
      string :text, empty: true, nils: true
    end
  end

  def execute
    n = Note.new(self.note)
    n.project = project

    add_error(:current_user, :unauthorized, 'not authorized') unless current_user.can_create?(n)

    n.save

    return n
  end
end
