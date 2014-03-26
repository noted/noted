class NotesController < ActionController::Base
  layout 'application'

  def index
    @notes = Note.where(project_id: current_project.id)
    @tags  = Note.tags_for(current_project)
  end

  def new
    @note = NoteCreate.run(
      current_user: current_user,
      project: current_project,
      note: {
        title: 'Untitled',
        text: ''
      }
    )

    redirect_to current_project.path("/notes/#{@note.result.id}")
  end

  def create
  end

  def show
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
      redirect_to current_project.path("/notes/#{@note.result.id}")
    end
  end

  def destroy
    @note = NoteDestroy.run(
      current_user: current_user,
      note: {
        id: params[:id]
      }
    )

    redirect_to current_project.path("/notes")
  end

  protected

  def current_project
    @user = User.where(username: params[:user]).first
    @project = Project.where(owner_id: current_user.id, permalink: params[:project]).first
  end
end
