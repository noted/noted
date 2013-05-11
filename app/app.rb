require 'yaml'

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

    segment = YAML.load_file(Padrino.root('.segment.yml'))

    Analytics.init(
      :secret => segment['secret']
    )

    set :cache, Padrino::Cache::Store::Memcache.new(::Memcached.new('127.0.0.1:11211', :exception_retry_limit => 1))

    configure :development do
      use BetterErrors::Middleware

      BetterErrors.application_root = PADRINO_ROOT
    end

    configure :production do
      enable :caching
    end

    Dir[Padrino.root('app/mutations/**/*.rb')].each { |f| require f }
  end
end
