Noted::Web.helpers do
  def current_user
    User.find(session[:noted])
  end

  def authorize(user)
    session[:noted] ||= 0
    session[:noted] = user.id

    Analytics.identify(
      :user_id => user.id.to_s,
      :traits => {
        :name => user.name,
        :username => user.username,
        :email => user.email
      }
    )
  end

  def deauthorize!
    session[:noted] = nil
    session[:noted].nil?
  end
end
