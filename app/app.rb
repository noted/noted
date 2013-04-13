module Noted
  class Web < Padrino::Application
    register Padrino::Cache
    register Padrino::Helpers
    register Padrino::Rendering

    register BaristaInitializer
    register CompassInitializer

    enable :sessions

    configure :development do
      use BetterErrors::Middleware

      BetterErrors.application_root = PADRINO_ROOT
    end

    MongoMapper::Document.plugin(MongoMapper::Plugins::IdentityMap)

    Dir[Padrino.root("app/mutations/**/*.rb")].each {|f| require f }
  end
end
