class ProjectsController < ActionController::Base
  layout 'application'

  def index
  end

  def new
    @project = Project.new
  end

  def create
    @project = ProjectCreate.run(
      current_user: current_user,
      project: params[:project]
    )

    redirect_to @project.result.path
  end

  def show
    @notes = Note.where(project_id: current_project.id).sort('updated_at desc')
    @sources = Source.where(project_id: current_project.id).sort('updated_at desc')

    @spans = {
      notes:   'col-15 suffix-1',
      sources: 'col-8 omega'
    }
  end

  def edit
  end

  def update
  end

  def destroy
  end

  protected

  def current_project
    @user = User.where(username: params[:user]).first
    @project = Project.where(owner_id: @user.id, permalink: params[:project]).first
  end
end
