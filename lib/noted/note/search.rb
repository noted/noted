class NoteSearch < Mutations::Command
  required do
    model :current_user, class: User
    model :project
    string :query
  end

  def execute
    return add_error(:current_user, :unauthorized, 'not authorized') unless current_user.can_view?(project)

    results = project.notes.full_text_search(query)

    return results
  end
end
