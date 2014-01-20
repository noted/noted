class DeviseFailure < Devise::FailureApp
  def redirect_url
    login_url
  end

  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end
end
