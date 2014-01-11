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

    redirect_to @project.result
  end

  def show
  end

  def update
  end

  def destroy
  end
end
