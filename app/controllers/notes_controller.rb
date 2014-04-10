class NotesController < ApplicationController
  before_filter :view_project?

  def index
    @notes = Note.where(project_id: @view_project.id)
    @tags  = Note.tags_for(@view_project)
  end

  def new
    @note = NoteCreate.run(
      current_user: current_user,
      project: @view_project,
      note: {
        title: 'Untitled',
        text: ''
      }
    )

    redirect_to @view_project.path("/notes/#{@note.result.id}")
  end

  def create
  end

  def show
    @footer = false
  end

  def update
    @note = NoteUpdate.run(
      current_user: current_user,
      note: params[:note]
    )
    if params[:ajax] == "true"
      result = { success: true }.to_json

      render json: result
    else
      redirect_to @view_project.path("/notes/#{@note.result.id}")
    end
  end

  def destroy
    @note = NoteDestroy.run(
      current_user: current_user,
      note: {
        id: params[:id]
      }
    )

    project = Project.find(params[:project])

    redirect_to project.path("/notes")
  end
end
