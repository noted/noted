Noted.controllers :projects do
  get :new, :map => "/new" do
    render 'projects/new'
  end

  post :create do
    p = Project::Create.run({
      :user => params[:user],
      :project => params[:project]
    })

    if p.success?
      redirect p.result.url
    else
      flash[:error] = "Something has gone awry."
      redirect url(:projects, :new)
    end
  end

  get :view, :map => "/:user/:project" do
    @user = User.find_by_username(params[:user])
    @project = Project.where(:user_id => @user.id, :permalink => params[:project]).first
    @notes = Note.where(:project_id => @project.id).order("updated_at dsc").all
    @sources = Source.where(:project_id => @project.id).order("updated_at dsc").all

    render 'projects/view'
  end

  get :edit, :map => "/:user/:project/settings" do
    @user = User.find_by_username(params[:user])
    @project = @user.projects.find_by_permalink(params[:project])

    render 'projects/edit'
  end

  patch :update do
    p = Project::Update.run({
      :author => params[:author],
      :project => params[:project]
    })

    if p.success?
      redirect p.result.url
    else
      flash[:error] = p.errors.message
      redirect "#{Project.find(params[:project][:id]).url}/settings"
    end
  end

  delete :destroy do
    p = Project::Destroy.run({
      :author => params[:author],
      :project => params[:project]
    })

    if p.success?
      redirect "/#{User.find(params[:author]).username}"
    else
      flash[:error] = "Something has gone awry."
      redirect Project.find(params[:project][:id]).url
    end
  end
end
