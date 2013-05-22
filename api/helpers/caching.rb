Noted::API.helpers do
  def expire!(key)
    if Noted::Web.cache.get(key)
      expire(key)
    end
  end
end
