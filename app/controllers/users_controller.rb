class UsersController < ActionController::Base
  layout 'application'

  def index
  end

  def new
  end

  def create
  end

  def show
    @user = User.where(username: params[:user]).first

    if @user
      @projects = @user.all_projects.sort('updated_at desc')
    else
      not_found
    end
  end

  def update
  end

  def destroy
  end

  protected

  def not_found
    render 'errors/404', status: 404
  end
end
