module Noted
  class Web < Padrino::Application
    register Padrino::Cache
    register Padrino::Helpers
    register Padrino::Rendering
    register Padrino::Sprockets

    asset_paths = [
      'assets/css',
      'assets/jsc',
      'assets/img',
      'assets/webfonts'
    ]

    sprockets :url => 'i', :minify => (Padrino.env == :production), :paths => asset_paths

    enable :sessions

    set :cache, Padrino::Cache::Store::Memcache.new(::Memcached.new('127.0.0.1:11211', :exception_retry_limit => 1))

    configure :development do
      use BetterErrors::Middleware

      BetterErrors.application_root = PADRINO_ROOT
    end

    configure :production do
      enable :caching

      if CONFIG['sentry']['dsn']
        Raven.configure do |config|
          config.dsn = CONFIG['sentry']['dsn']
        end

        use Raven::Rack
      end
    end

    Dir[Padrino.root('app/mutations/**/*.rb')].each { |f| require f }
  end
end
