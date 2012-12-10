module Gatekeeper
  def current_user
    User.find_by_hash(session["noted"])
  end

  def login(user)
    session[:noted] = user.password
  end

  def logout!
    session[:noted] = nil
    session[:noted].nil?
  end

  def logged_in?
    !session[:noted].blank?
  end
end

Noted.helpers Gatekeeper
