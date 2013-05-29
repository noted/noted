module Noted
  class Admin < Padrino::Application
    register Padrino::Cache
    register Padrino::Helpers
    register Padrino::Rendering
    register Padrino::Sprockets

    enable :sessions

    asset_paths = [
      'assets/css',
      'assets/jsc',
      'assets/img',
      'assets/webfonts'
    ]

    sprockets :url => 'i', :minify => (Padrino.env == :production), :paths => asset_paths

    configure :development do
      use BetterErrors::Middleware

      BetterErrors.application_root = PADRINO_ROOT
    end

    set :cache, Padrino::Cache::Store::Memcache.new(::Dalli::Client.new('127.0.0.1:11211', :exception_retry_limit => 1))

    configure :production do
      enable :caching
    end
  end
end
