Noted::Web.helpers do
  def current_user
    User.find(session[:noted])
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
