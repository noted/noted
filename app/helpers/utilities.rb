Noted::Web.helpers do
  def format(type, str)
    case type
    when :url
      str.sub(/^https?\:\/\//, '').sub(/^www./,'')
    when :twitter
      str.insert(0, "@")
    when :search
      str.downcase.gsub(/[^a-z ]/, '').gsub(/ /, '+')
    when :unsearch
      str.replace("+", " ")
    else
      str
    end
  end

  def safe(str)
    str.html_safe
  end
end
