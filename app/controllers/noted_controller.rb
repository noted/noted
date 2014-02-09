class NotedController < ActionController::Base
  layout 'application'

  def index
    if current_user
      render 'projects/index'
    else
      @projects = Project.where(user_id: current_user.id).all

      render 'users/show'
    end
  end
end
