Noted::Web.controllers do
  get :index do
    if current_user
      redirect url(:users, :view, :user => current_user.username)
    else
      render 'core/index'
    end
  end

  get :about do
    render 'core/about'
  end

  get :blog do
    redirect 'http://blog.getnotedapp.com'
  end

  get :roadmap do
    render 'core/roadmap'
  end

  get :support do
    render 'core/support'
  end
end
