Noted::Admin.helpers do
  def current_user
    User.find(session[:noted])
  end

  def authorize!
    if current_user
      unless current_user.staff?
        redirect Noted::Web.url(:sessions, :new)
      end
    else
      redirect Noted::Web.url(:sessions, :new)
    end
  end

  def authorize(user)
    session[:noted] ||= 0
    session[:noted] = user.id
  end

  def deauthorize!
    session[:noted] = nil
    session[:noted].nil?
  end
end
