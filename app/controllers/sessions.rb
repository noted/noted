Noted::Web.controllers :sessions do
  get :new, :map => '/login' do
    if current_user
      redirect url(:index)
    else
      render 'sessions/new', :layout => 'sessions'
    end
  end

  post :create do
    if u = User.authenticate(params[:user][:email], params[:user][:password])
      authorize(u)
      redirect url(:index)
    else
      flash[:error] = 'Something has gone awry.'
      redirect url(:sessions, :new)
    end
  end

  get :destroy, :map => '/logout' do
    if deauthorize!
      redirect url(:index)
    end
  end
end
