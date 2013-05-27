Noted::Web.helpers do
  def current_project
    if params[:user] && params[:project]
      @user = User.find_by_username(params[:user])
      @project = Project.given(@user.id, params[:project]).first

      unless @user && @project
        halt 404
      end
    end
  end
end
