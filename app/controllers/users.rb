Noted.controllers :users do
  get :new, :map => "/join" do
    render 'users/new'
  end

  post :create do
    u = User::Create.run({
      :user => params[:user]
    })

    if u.success?
      login(u.result)
      redirect url(:index)
    else
      flash[:error] = "Something has gone awry."
      redirect url(:users, :new)
    end
  end

  get :edit, :map => "/settings" do
    @user = current_user

    render 'users/edit'
  end

  patch :update do
    u = User::Update.run({
      :user => params[:user]
    })

    if u.success?
      flash[:notice] = "Your profile has been updated."
      redirect url(:users, :edit)
    else
      flash[:error] = u.errors.message_list
      redirect url(:users, :edit)
    end
  end

  delete :destroy do
    u = User::Destroy.run({
      :user => params[:user]
    })

    if u.success?
      flash[:notice] = "We're sorry to see you go."
      redirect url(:index)
    else
      flash[:error] = "Something has gone awry."
      redirect url(:users, :edit)
    end
  end

  get :view, :map => "/:user" do
    @user = User.find_by_username(params[:user])
    @projects = Project.where(:user_id => @user.id).order("updated_at dsc")

    render 'users/view'
  end
end
