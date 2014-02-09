class NotedController < ActionController::Base
  layout 'application'

  def index
    if current_user
      @projects = Project.where(user_id: current_user.id).all

      d { current_user }

      render 'projects/index'
    else
      render 'noted/index'
    end
  end
end
