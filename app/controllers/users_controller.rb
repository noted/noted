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
    @projects = @user.all_projects.sort('updated_at desc')
  end

  def update
  end

  def destroy
  end
end
