Noted::Web.helpers do
  def format_url(str)
    str.sub(%r{^https?\:\/\/}, '').sub(%r{^www.}, '')
  end

  def safe(str)
    str.html_safe
  end
end
