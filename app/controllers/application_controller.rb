class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  helper :all

  def after_sign_in_path_for(resource)
    root_path
  end

  def peek_enabled?
    current_user.admin?
  end

  protected

  # Devise needs to be configured to whitelist parameters.
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :name, :username, :password, :password_confirmation)
    end
  end
end
