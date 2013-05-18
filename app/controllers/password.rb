Noted::Web.controllers :password do
  get :reset do
    render 'password/reset'
  end

  post :reset do
    e = Password::Reset.run({
      :user => params[:user]
    })

    if e.success?
      flash[:notice] = 'Check your email.'
      redirect url(:index)
    else
      flash[:error] = 'Something has gone awry.'
      redirect url(:password, :reset)
    end
  end

  get :recover, :with => :token do
    @user = User.where(:token => params[:token]).first

    render 'password/recover'
  end

  post :recover do
    u = Password::Recover.run({
      :user => params[:user],
      :password => params[:password]
    })

    if u.success?
      authorize(u.result)

      flash[:notice] = 'Your password has been reset.'
      redirect url(:index)
    else
      flash[:error] = 'Something has gone awry.'
      redirect url(:password, :reset, :token => u.result.token)
    end
  end
end
