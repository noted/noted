Noted.controllers :users do
  get :new, :map => "/join" do
    render "users/new"
  end

  post :create do
    u = User.new(params[:user])
    u.password = params[:password]

    if u.save
      flash[:notice] = "Welcome to Noted!"
      redirect url(:dashboard, :index)
    else
      flash[:error] = "Something has gone amiss..."
      redirect url(:users, :new)
    end
  end

  get :edit, :map => "/settings" do
  end

  put :modify do
  end

  delete :destroy do
  end
  
  get :view, :map => "/:username" do
    @user = User.find(:username => params[:username])

    render "users/view"
  end
end