class NotedController < ApplicationController
  def index
    if current_user
      @projects = current_user.all_projects.sort('updated_at desc')

      render 'projects/index'
    else
      render 'noted/index'
    end
  end

  def ui
    render 'noted/ui'
  end
end
