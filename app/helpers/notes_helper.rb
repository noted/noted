module NotesHelper
  def current_note
    @note = current_project.notes.find(params[:note])
  end
end
