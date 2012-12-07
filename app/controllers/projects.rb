Noted.controllers :projects do
  get :new do
    render 'projects/new'
  end

  post :create do
    u = User.find(params[:user])
    p = Project.new(params[:project])

    if p.save && u.projects << p
      flash[:notice] = "#{p.title} has been created."
      redirect url(:projects, :view, :user => u.username, :project => p.permalink)
    else
      flash[:error] = "Something has gone awry."
      redirect url(:projects, :new)
    end
  end

  get :view, :map => "/:user/:project" do
    @user = User.find_by_username(params[:user])
    @project = @user.projects.find_by_permalink(params[:project])

    render 'projects/view'
  end

  get :edit, :map => "/:user/:project/settings" do
    @user = User.find_by_username(params[:user])
    @project = @user.projects.find_by_permalink(params[:project])

    render 'projects/edit'
  end

  patch :update do
    p = Project.find(params[:id])

    if p.update_attributes(params[:project])
      flash[:notice] = "#{p.title} has been modified."
      redirect url(:projects, :edit, :user => p.user.username, :project => p.permalink)
    else
      flash[:error] = "Something has gone wrong..."
      redirect url(:projects, :edit, :user => params[:user_id], :project => p.permalink)
    end
  end

  delete :destroy do
    p = Project.find(params[:id])

    if p.destroy
      flash[:notice] = "Your project has been destroyed."
      redirect url(:users, :view, :user => User.find(params[:user]).username)
    else
      flash[:error] = "Something went wrong."
      redirect url(:projects, :edit, :user => p.user.username, :project => p.permalink)
    end
  end
end