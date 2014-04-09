class ProjectsController < ApplicationController
  before_filter :view_project?

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
    @notes = Note.where(project_id: view_project.id).sort('updated_at desc')
    @sources = Source.where(project_id: view_project.id).sort('updated_at desc')

    @spans = {
      notes:   'col-15 suffix-1',
      sources: 'col-8 omega'
    }
  end

  def edit
  end

  def update
    @project = ProjectUpdate.run(
      current_user: current_user,
      project: params[:project]
    )

    redirect_to @project.result.path('/settings')
  end

  def destroy
  end
end
