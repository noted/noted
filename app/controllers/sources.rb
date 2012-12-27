Noted.controllers :sources do
  before :except => [:create, :update, :destroy] do
    if params[:user] && params[:project]
      @user = User.find_by_username(params[:user])
      @project = @user.projects.find_by_permalink(params[:project])
    end
  end

  get :index, :map => "/:user/:project/sources" do
    @sources = @project.sources.all

    render 'sources/index'
  end

  get :new, :map => "/:user/:project/sources/new" do
    render 'sources/new'
  end

  post :create do
    p = Project.find(params[:project])

    s = Source.new(params[:source])
    s.creator = User.find(params[:author])

    if s.save && p.sources << s
      redirect url(:sources, :view, :user => p.user.username, :project => p.permalink, :source => s.permalink)
    else
      redirect url(:sources, :new, :user => p.user.username, :project => p.permalink)
    end
  end

  get :view, :map => "/:user/:project/sources/:source" do
    @source = @project.sources.find_by_permalink(params[:source])

    render 'sources/view'
  end

  patch :update do
    s = Source.find(params[:id])
    s.updater = User.find(params[:author])

    if s.update_attributes(params[:source])
      redirect url(:sources, :view, :user => s.project.user.username, :project => s.project.permalink, :source => s.permalink)
    else
      flash[:error] = "Something has gone awry."
      redirect url(:sources, :view, :user => s.project.user.username, :project => s.project.permalink, :source => s.permalink)
    end
  end

  delete :destroy do
    s = Source.find(params[:id])
    p = s.project
    u = p.user

    if s.destroy
      redirect url(:sources, :index, :user => u.username, :project => p.permalink)
    else
      flash[:error] = "Something has gone awry."
      redirect url(:sources, :view, :user => u.username, :project => p.permalink, :source => s.permalink)
    end
  end
end