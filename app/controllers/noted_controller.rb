class NotedController < ActionController::Base
  layout 'application'

  def index
    if current_user
      render 'projects/index'
    else
      render 'noted/index'
    end
  end
end
