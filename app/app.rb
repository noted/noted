class Noted < Padrino::Application
  register Padrino::Cache
  register Padrino::Helpers
  register Padrino::Mailer
  register Padrino::Rendering

  register Padrino::Warden
  
  register BaristaInitializer
  register CompassInitializer

  enable :sessions

  Warden::Strategies.add(:password) do
    def valid?
      params[:user][:email] || params[:user][:password]
    end

    def authenticate!
      u = User.authenticate(params[:user][:email], params[:user][:password])
      u.nil? ? fail!("Your username or password was incorrect.") : success!(u)
    end
  end

  Warden::Manager.serialize_into_session do |user|
    user.id
  end

  Warden::Manager.serialize_from_session do |id|
    User.get(id)
  end
end
