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
    @projects = Project.where(owner_id: @user.id).all
  end

  def update
  end

  def destroy
  end
end
