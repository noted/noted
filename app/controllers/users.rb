Noted.controllers :users do
  before :view do
    current_state
  end

  get :new, :map => '/join' do
    render 'users/new'
  end

  post :create do
    u = User.new(params[:user])
    u.password = params[:password]

    if u.save
      flash[:notice] = "Welcome to Noted!"
      redirect url(:index)
    else
      flash[:error] = "Something has gone awry. #{u.errors}"
      redirect url(:users, :new)
    end
  end

  get :edit, :map => "/settings" do
    render 'users/edit'
  end

  patch :update do
    u = User.find(params[:id])

    if u.update_attributes(params[:user])
      flash[:notice] = "Your profile has been updated."
      redirect url(:users, :edit)
    else
      flash[:error] = "Something has gone awry. #{u.errors}"
      redirect url(:users, :edit)
    end
  end

  delete :destroy do
    u = User.find(params[:id])

    if u.destroy
      flash[:notice] = "We're sorry to see you go. :("
      redirect url(:index)
    else
      flash[:error] = "Something has gone awry. #{u.errors}"
      redirect url(:users, :edit)
    end
  end

  get :view, :map => '/:user' do
    render 'users/view'
  end
end