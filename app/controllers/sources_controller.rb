class SourcesController < ActionController::Base
  layout 'application'

  def index
    not_implemented
  end

  def new
    not_implemented
  end

  def create
  end

  def show
  end

  def update
  end

  def destroy
  end

  protected

  def not_implemented
    if Rails.env == 'production'
      render 'errors/501', status: 501
    end
  end
end
