module ApplicationHelper
  def current_project
    @user = User.where(username: params[:user]).first
    @project = Project.where(user_id: current_user.id, permalink: params[:project]).first
    @project
  end
end
