Noted.controllers :notes do
  before do
    if params[:user] && params[:project]
      @user = User.find_by_username(params[:user])
      @project = Project.where(:user_id => @user.id, :permalink => params[:project]).first
    end
  end

  get :index, :map => "/:user/:project/notes" do
    @notes = @project.notes.all

    render 'notes/index'
  end

  post :create do
    p = Project.find(params[:project])

    n = Note.new(:title => "Untitled")
    n.creator = User.find(params[:author])

    if n.save && p.notes << n
      redirect url(:notes, :view, :user => p.user.username, :project => p.permalink, :note => n.permalink)
    else
      flash[:error] = "Something has gone awry."
      redirect url(:notes, :index, :user => p.user.username, :project => p.permalink)
    end
  end

  get :view, :map => "/:user/:project/notes/:note" do
    @note = Note.where(:project_id => @project.id, :permalink => params[:note])

    render 'notes/view'
  end

  patch :update do
    n = Note.find(params[:id])
    n.updater = User.find(params[:author])

    if n.update_attributes(params[:note])
      redirect url(:notes, :index, :user => n.project.user.username, :project => n.project.permalink)
    else
      flash[:error] = "Somethng has gone awry."
      redirect url(:notes, :view, :user => n.project.user.username, :project => n.project.permalink, :note => n.permalink)
    end
  end

  delete :destroy do
    n = Note.find(params[:id])
    p = n.project
    u = p.user

    if n.destroy
      redirect url(:notes, :index, :user => u.username, :project => p.permalink)
    else
      flash[:error] = "Somethng has gone awry."
      redirect url(:notes, :view, :user => u.username, :project => p.permalink)
    end
  end
end