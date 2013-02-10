Noted.helpers do
  def format(type, str)
    case type
    when :url
      str.sub(/^https?\:\/\//, '').sub(/^www./,'')
    when :twitter
      str.insert(0, "@")
    else
      str
    end
  end
end
