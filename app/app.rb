module Noted
  class Web < Padrino::Application
    register Padrino::Cache
    register Padrino::Helpers
    register Padrino::Rendering
    register Padrino::Assets

    enable :caching
    enable :sessions

    set :cache, Padrino::Cache::Store::Memcache.new(::Memcached.new('127.0.0.1:11211', :exception_retry_limit => 1))

    set :compress_assets, true
    set :css_compressor, YUI::CssCompressor

    configure :development do
      use BetterErrors::Middleware

      BetterErrors.application_root = PADRINO_ROOT
    end

    MongoMapper::Document.plugin(MongoMapper::Plugins::IdentityMap)

    Dir[Padrino.root("app/mutations/**/*.rb")].each {|f| require f }
  end
end
