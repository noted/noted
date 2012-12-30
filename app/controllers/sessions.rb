Noted.controllers :sessions do
  get :new, :map => "/login" do
    render 'sessions/new', layout: false
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