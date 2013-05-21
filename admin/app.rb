module Noted
  class Admin < Padrino::Application
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
  end
end
