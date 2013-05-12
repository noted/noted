Noted::API.helpers do
  def authorize!
    unless current_user
      halt 403
    end
  end

  def current_user
    User.find(params[:current_user])
  end
end
