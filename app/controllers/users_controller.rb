class UsersController < ApplicationController
  before_filter :view_user?, only: [:show]

  def index
  end

  def new
  end

  def create
  end

  def show
    @projects = view_user.all_projects.sort('updated_at desc')
  end

  def update
  end

  def destroy
  end
end
