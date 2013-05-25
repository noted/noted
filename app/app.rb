require 'yaml'

module Noted
  class Web < Padrino::Application
    register Padrino::Cache
    register Padrino::Helpers
    register Padrino::Mailer
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

    set :cache, Padrino::Cache::Store::Memcache.new(::Dalli::Client.new('127.0.0.1:11211', :exception_retry_limit => 1))

    configure :development, :production do
      set :delivery_method, :smtp => {
        :address => SMTP['address'],
        :port => SMTP['port'],
        :user_name => SMTP['username'],
        :password => SMTP['password']
      }
    end

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

    configure :test do
      set :delivery_method, :test
    end

    error 404 do
      render 'core/404'
    end

    error 500 do
      render 'core/500'
    end
  end
end
