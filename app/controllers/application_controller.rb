class ApplicationController < ActionController::Base
  include Finders
  include Errors

  helper :all

  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  helper_method :view_user, :view_project, :view_note, :view_user?,
                :view_project?, :view_note?, :peek_enabled?, :not_implemented,
                :not_found, :devise_error_messages!

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

    html = '<ul>'
    hsh.each do |field, message|
      unless html.include?("<li>#{message}</li>")
        html << "<li>#{message}</li>"
      end
    end

    html = html << '</ul>'

    html
  end

  def devise_error_messages!
    return '' if resource.errors.empty?

    full_messages = resource.errors.full_messages.uniq
    messages = full_messages.map { |msg| "<li>#{msg}</li>" }.join

    html = <<-HTML
    <div class="flash alert">
      <div class="container">
        <section>
          <p>#{messages}</p>
        </section>
        <aside>
          <a class="flash-hide">
            <i class="ss-icon">close</i>
          </a>
        </aside>
      </div>
    </div>
    HTML

    html.html_safe
  end

  protected

  # Devise needs to be configured to whitelist parameters.
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :name, :username, :password, :password_confirmation)
    end
  end
end
