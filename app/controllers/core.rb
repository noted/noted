Noted::Web.controllers do
  get :index do
    if current_user
      redirect url(:users, :view, :user => current_user.username)
    else
      render 'core/index'
    end
  end

  get :blog do
  end

  get :explore do
  end

  get :features do
  end

  get :pricing do
  end

  get :documentation do
  end

  get :support do
  end
end
