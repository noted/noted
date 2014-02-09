class NotesController < ActionController::Base
  layout 'application'

  def index
    @notes = current_project.notes.all
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
  end

  def destroy
  end

  protected

  def current_project
    @user = User.where(username: params[:user]).first
    @project = Project.where(user_id: current_user.id, permalink: params[:project]).first
    @project
  end
end
