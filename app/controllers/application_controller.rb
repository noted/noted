class ApplicationController < ActionController::Base
  helper :all

  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  helper_method :view_user, :view_project, :view_note, :view_user?,
                :view_project?, :view_note?, :peek_enabled?, :not_implemented,
                :not_found

  def view_user
    @view_user = User.where(username: params[:user]).first
    @view_user
  end

  def view_project
    if view_user.nil?
      @view_project = nil
    else
      @view_project = Project.where(owner_id: view_user.id, permalink: params[:project]).first
    end

    @view_project
  end

  def view_note
    @view_note = Note.find(params[:note])
    @view_note
  end

  def view_user?
    if view_user.nil?
      not_found
    end
  end

  def view_project?
    if view_project.nil?
      not_found
    end
  end

  def view_note?
    if view_note.nil?
      not_found
    end
  end

  def peek_enabled?
    if current_user && current_user.admin?
      true
    end
  end

  def after_sign_in_path_for(resource)
    root_path
  end

  def not_implemented
    if Rails.env == 'production'
      render 'errors/501', status: 501
    end
  end

  def not_found
    render 'errors/404', status: 404
  end

  protected

  # Devise needs to be configured to whitelist parameters.
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :name, :username, :password, :password_confirmation)
    end
  end
end
