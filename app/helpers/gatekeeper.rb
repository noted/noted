module Gatekeeper
  def current_user
    User.find_by_hash(session[:noted])
  end

  def authorize(user)
    session[:noted] ||= 0
    session[:noted] = user.hash
  end

  def deauthorize!
    session[:noted] = nil
    session[:noted].nil?
  end
end

Noted::Web.helpers Gatekeeper
