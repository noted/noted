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
  end
end