class ProjectsController < ApplicationController
  before_filter :view_project?, only: [:show, :edit]

  layout 'application'

  def new
    @project = Project.new
  end

  def create
    @project = ProjectCreate.run(
      current_user: current_user,
      project: params[:project]
    )

    if @project.success?
      redirect_to @project.result.path
    else
      redirect_to new_path, alert: format_error!(@project.errors).html_safe
    end
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
