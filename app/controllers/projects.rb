Noted.controllers :projects do
  get :new, :map => "/new" do
    render 'projects/new'
  end

  post :create do
    u = User.find(params[:user])

    p = Project.new(params[:project])
    p.creator = User.find(params[:author])

    if p.save && u.projects << p
      redirect url(:projects, :view, :user => u.username, :project => p.permalink)
    else
      flash[:error] = "Something has gone awry."
      redirect url(:projects, :new)
    end
  end

  get :view, :map => "/:user/:project" do
    @user = User.find_by_username(params[:user])
    @project = Project.where(:user_id => @user.id, :permalink => params[:project]).order("updated_at dsc").first

    render 'projects/view'
  end

  get :edit, :map => "/:user/:project/settings" do
    @user = User.find_by_username(params[:user])
    @project = @user.projects.find_by_permalink(params[:permalink])

    render 'projects/edit'
  end

  patch :update do
    p = Project.find(params[:id])
    p.updater = User.find(params[:author])

    if p.update_attributes(params[:project])
      redirect url(:projects, :view, :user => p.user.username, :project => p.permalink)
    else
      flash[:error] = "Something has gone awry."
      redirect url(:project, :edit, :user => p.user.username, :project => p.permalink)
    end
  end

  delete :destroy do
    p = Project.find(params[:id])
    u = p.user

    if p.destroy
      redirect url(:users, :view, :user => u.username)
    else
      flash[:error] = "Something has gone awry."
      redirect url(:projects, :edit, :user => p.user.username, :project => p.permalink)
    end
  end
end