module Errors
  def not_implemented
    if Rails.env == 'production'
      render 'errors/501', status: 501
    end
  end

  def not_found
    render 'errors/404', status: 404
  end
end
