module ApplicationHelper
  def current_project
    @user = User.where(username: params[:user]).first
    @project = Project.where(owner_id: @user.id, permalink: params[:project]).first
  end
end
