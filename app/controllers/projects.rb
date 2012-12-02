Noted.controllers :projects do
  get :new do
    render 'projects/new'
  end

  post :create do
    u = User.find(params[:user_id])
    p = Project.new(params[:project])

    if p.save && u.projects << p
      flash[:notice] = "Your project #{p.title} has been created."
      redirect url(:projects, :view, :username => u.username, :project => p.permalink)
    else
      flash[:error] = "Something has gone wrong. #{p.errors}"
      redirect url(:projects, :new)
    end
  end

  get :view, :map => "/:username/:project" do
    @user = User.find_by_username(params[:username])
    @project = @user.projects.find_by_permalink(params[:project])

    render 'projects/view'
  end

  get :edit, :map => "/:username/:project/settings" do
    @user = User.find_by_username(params[:username])
    @project = @user.projects.find_by_permalink(params[:project])

    render 'projects/edit'
  end

  patch :modify do
    p = Project.find(params[:id])

    if p.update_attributes(params[:project])
      flash[:notice] = "#{p.title} has been modified."
      redirect url(:projects, :edit, :username => p.user.username, :project => p.permalink)
    else
      flash[:error] = "Something has gone wrong..."
      redirect url(:projects, :edit, :username => params[:user_id], :project => p.permalink)
    end
  end

  delete :destroy do
    p = Project.find(params[:id])

    if p.destroy
      flash[:notice] = "Your project has been destroyed."
      redirect url(:users, :view, :username => User.find(params[:user]).username)
    else
      flash[:error] = "Something went wrong."
      redirect url(:projects, :edit, :username => p.user.username, :project => p.permalink)
    end
  end
end