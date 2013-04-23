Noted::Web.helpers do
  def format_url(str)
    str.sub(/^https?\:\/\//, '').sub(/^www./, '')
  end

  def safe(str)
    str.html_safe
  end
end
