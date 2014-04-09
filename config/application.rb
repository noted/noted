require File.expand_path('../boot', __FILE__)

require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'sprockets/railtie'

Bundler.require(:default, Rails.env)

module Noted
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run 'rake -D time' for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # HACK: Add Mutations in lib/noted.
    config.paths.add 'lib/noted', glob: '**/*.rb'
    config.autoload_paths += %W(#{config.root}/lib)

    config.assets.paths << "#{Rails.root}/app/assets/css"
    config.assets.paths << "#{Rails.root}/app/assets/img"
    config.assets.paths << "#{Rails.root}/app/assets/jsc"
    config.assets.paths << "#{Rails.root}/app/assets/webfonts"

    config.compass.require 'susy'

    config.action_controller.include_all_helpers = true
  end
end
