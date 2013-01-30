module Gatekeeper
  def current_user
    User.find_by_hash(session[:noted])
  end

  def login(user)
    session[:noted] ||= 0
    session[:noted] = user.hash
  end

  def logout!
    session[:noted] = nil
    session[:noted].nil?
  end
end

Noted.helpers Gatekeeper
