Noted.controllers :sessions do
  get :new, :map => "/login" do
    if current_user
      redirect url(:index)
    else
      render 'sessions/new', layout: :sessions
    end
  end

  post :create do
    if u = User.authenticate(params[:user][:email], params[:user][:password])
      login(u)
      redirect url(:index)
    end
  end

  get :destroy, :map => "/logout" do
    if logout!
      redirect url(:index)
    end
  end
end