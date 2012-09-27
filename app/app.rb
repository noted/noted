class Noted < Padrino::Application
  register Padrino::Cache
  register Padrino::Helpers
  register Padrino::Mailer
  register Padrino::Rendering
  register Padrino::Warden
  register BaristaInitializer
  register CompassInitializer

  enable :caching
  enable :sessions

  set :cache, Padrino::Cache::Store::Redis.new(::Redis.new(:host => '127.0.0.1', :port => 6379, :db => 0))

  Warden::Strategies.add(:password) do
    def valid?
      params["email"] || params["password"]
    end

    def authenticate!
      u = User.authenticate(params["email"], params["password"])
      u.nil? ? fail!("Could not log in") : success!(u)
    end
  end

  Warden::Manager.serialize_into_session do |user|
    user.id
  end

  Warden::Manager.serialize_from_session do |id|
    User.get(id)
  end
end
