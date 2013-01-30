Noted.controllers do
  get :index do
    if current_user
      render 'core/dashboard'
    else
      render 'core/index'
    end
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
