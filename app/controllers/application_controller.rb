class ApplicationController < ActionController::Base
  include Finders
  include Errors

  helper :all

  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  helper_method :view_user, :view_project, :view_note, :view_user?,
                :view_project?, :view_note?, :peek_enabled?, :not_implemented,
                :not_found

  def peek_enabled?
    if current_user && current_user.admin?
      true
    end
  end

  def after_sign_in_path_for(resource)
    root_path
  end

  def format_error!(errors)
    hsh = errors.message.first[1]

    d { hsh }

    html = '<ul>'
    hsh.each do |field, message|
      html << "<li>#{message}</li>"
    end

    html = html << '</ul>'

    d { html }

    html
  end

  protected

  # Devise needs to be configured to whitelist parameters.
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :name, :username, :password, :password_confirmation)
    end
  end
end
