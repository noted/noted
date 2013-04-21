Noted::Web.controllers :projects do
  get :new, :map => "/new" do
    if current_user
      render 'projects/new'
    else
      redirect url(:index)
    end
  end

  post :create do
    p = Project::Create.run({
      :user => params[:user],
      :project => params[:project]
    })

    if p.success?
      expire("#{p.result.user.id}_projects")

      redirect p.result.url
    else
      flash[:error] = "Something has gone awry. #{p.errors.message_list}"
      redirect url(:projects, :new)
    end
  end

  get :view, :map => "/:user/:project" do
    @user = User.find_by_username(params[:user])
    @project = Project.where(:user_id => @user.id, :permalink => params[:project]).first

    @notes = cache("#{@project.id}_notes", :expires_in => 60) do
      @n = Note.where(:project_id => @project.id).order("updated_at dsc").all

      partial 'projects/notes'
    end

    @sources = cache("#{@project.id}_sources", :expires_in => 60) do
      @s = Source.where(:project_id => @project.id).order("updated_at dsc").all

      partial 'projects/sources'
    end

    render 'projects/view'
  end

  get :edit, :map => "/:user/:project/settings" do
    @user = User.find_by_username(params[:user])
    @project = @user.projects.find_by_permalink(params[:project])

    if current_user && @project.updatable_by?(current_user)
      render 'projects/edit'
    else
      redirect @project.url
    end
  end

  patch :update do
    p = Project::Update.run({
      :author => params[:author],
      :project => params[:project]
    })

    if p.success?
      redirect p.result.url

      expire("#{p.result.creator.id}_projects")
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
