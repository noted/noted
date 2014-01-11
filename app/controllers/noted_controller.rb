class NotedController < ActionController::Base
  layout 'application'

  def index
    if current_user
      render 'noted/dashboard'
    else
      render 'noted/index'
    end
  end
end
