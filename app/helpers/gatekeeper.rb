module Gatekeeper
  def authorize(user)
    session["noted"] = user.password
  end

  def current_user
    User.find_by_hash(session["noted"])
  end

  def logged_in?
    !session["noted"].blank?
  end
end

Noted.helpers Gatekeeper
