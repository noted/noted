Noted::Web.controllers :password do
  get :reset, :with => :token do
    @user = User.where(:token => params[:token]).first

    render 'password/reset'
  end

  post :create do
    u = Password::Create.run({
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
