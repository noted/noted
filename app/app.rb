class Noted < Padrino::Application
  register Padrino::Cache
  register Padrino::Helpers
  register Padrino::Mailer
  register Padrino::Rendering

  register BaristaInitializer
  register CompassInitializer

  enable :sessions
end
