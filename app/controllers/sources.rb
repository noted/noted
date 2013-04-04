Noted.controllers :sources do
  before :except => [:create, :update, :destroy] do
    if params[:user] && params[:project]
      @user = User.find_by_username(params[:user])
      @project = Project.where(:user_id => @user.id, :permalink => params[:project]).first
    end
  end

  get :index, :map => "/:user/:project/sources" do
    @sources = @project.sources.all

    render 'sources/index'
  end

  get :new, :map => "/:user/:project/sources/new" do
    render 'sources/new'
  end

  post :create do # Fix me!
    type = "#{params[:source][:type]}"

    attributes = params[type]
    attributes.merge({:type => type.to_sym})

    s = Source::Create.run({
      :project => params[:project],
      :author => params[:author],
      :source => { :attributes => attributes }
    })

    if s.success?
      redirect Project.find(params[:project]).url
    else
      redirect Project.find(params[:project]).url
    end
  end

  get :view, :map => "/:user/:project/sources/:source" do
    @source = Source.where(:project_id => @project.id, :permalink => params[:source])

    render 'sources/view'
  end

  patch :update do
    s = Source::Update({
      :author => params[:author],
      :source => params[:source]
    })

    if s.success?
      redirect s.result.url
    else
      flash[:error] = "Something has gone awry."
      redirect Source.find(params[:source][:id]).url
    end
  end

  delete :destroy do
    project = Source.find(params[:source][:id]).project

    s = Source::Destroy.run({
      :author => params[:author],
      :source => params[:source]
    })

    if s.success?
      redirect project.url
    else
      flash[:error] = "Something has gone awry."
      redirect project.url
    end
  end
end
