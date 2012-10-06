Noted.controllers :notes do
  get :index, :map => "/:user/:project/notes" do
    @user = User.where(:username => params[:user])
    @project = Project.where(:permalink => params[:project])
    @notes = @project.notes

    render 'notes/index'
  end

  get :new, :map => "/:user/:project/notes/new" do
    @user = User.where(:username => params[:user])
    @project = Project.where(:permalink => params[:project])

    render 'notes/new'
  end

  post :create do
    @user = User.find(params[:user_id])
    @project = Project.find(params[:project_id])
    
    @note = Note.new(params[:new])

    if @note.save
      @project.updater = current_user
      @note.creator = current_user

      flash[:notice] = "Your note has been created."
      redirect url(:notes, :index, :user => @user.username, :project => @project.permalink)
    else
      flash[:error] = "Something went wrong and your note hasn't been saved."
      redirect url(:notes, :new, :user => @user.username, :project => @project.permalink)
    end
  end

  get :view, :map => "/:user/:project/notes/:note" do
    @project = Project.where(:permalink => params[:project])
    @note = Note.find(params[:note])

    render 'notes/view'
  end

  put :modify do
    @user = User.find(params[:user_id])
    @project = Project.find(params[:project_id])
    @note = Note.find(params[:id])

    if @note.update_attributes(params[:note])
      @project.updater = current_user
      @note.updater = current_user

      flash[:notice] = "Your note has been modified."
      redirect url(:notes, :index, :user => @user.username, :project => @project.permalink)
    else
      flash[:error] = "Something went wrong and your note hasn't been saved."
      redirect url(:notes, :view, :user => @user.username, :project => @project.permalink, :note => params[:id])
    end
  end

  delete :destroy do
    @user = User.find(params[:user_id])
    @project = Project.find(params[:project_id])
    @note = Note.find(params[:id])

    if @note.destroy
      @project.updater = current_user

      flash[:notice] = "Your note has been deleted."
      redirect url(:notes, :index, :user => @user.username, :project => @project.permalink)
    else
      flash[:error] = "Something went wrong and your note hasn't been deleted."
      redirect url(:notes, :view, :user => @user.username, :project => @project.permalink, :note => params[:id])
    end
  end
end