Noted::Admin.controllers :users do
  get :index do
    @users = User.order('created_at dsc').limit(25)

    render 'users/index'
  end

  get :view, :with => :id do
    @user = User.find(params[:id])

    render 'users/view'
  end
end
