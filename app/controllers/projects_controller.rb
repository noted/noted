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

    redirect_to project_path(username: @project.result.user.username, project: @project.permalink)
  end

  def show
    @user = User.where(username: params[:user]).first
    @project = Project.where(user_id: @user.id, permalink: params[:project]).first
  end

  def update
  end

  def destroy
  end
end
