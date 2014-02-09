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
    @user = User.where(username: params[:user]).first
    @project = Project.where(user_id: current_user.id, permalink: params[:project]).first
  end

  def update
  end

  def destroy
  end
end
