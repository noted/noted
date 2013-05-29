Noted::Admin.controllers :users do
  get :index, :cache => true do
    expires_in 30

    @users = User.order('created_at dsc').limit(25)

    render 'users/index'
  end

  get :view, :with => :id, :cache => true do
    expires_in 60

    @user = User.find(params[:id])

    render 'users/view'
  end
end
