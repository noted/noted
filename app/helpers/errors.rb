Noted::Web.helpers do
  def error_404!
    response.status = 404

    render 'core/404'
  end

  def error_500!
    response.status = 500

    render 'core/500'
  end
end
