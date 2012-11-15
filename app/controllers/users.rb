Noted.controllers :users do
  get :new, :map => "/join" do
    render "users/new"
  end

  post :create do
  end

  get :view, :map => "/:username" do
    @user = User.find_by_username(params[:username])

    render "users/view"
  end

  put :modify do
  end

  delete :destroy do
  end
end