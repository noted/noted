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
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
