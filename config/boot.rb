PADRINO_ENV  = ENV['PADRINO_ENV'] ||= ENV['RACK_ENV'] ||= 'development'  unless defined?(PADRINO_ENV)
PADRINO_ROOT = File.expand_path('../..', __FILE__) unless defined?(PADRINO_ROOT)

COMMIT = `git show --pretty=%H`.split[0...1].join(' ')
BRANCH = `git rev-parse --abbrev-ref HEAD`

NOTED_VERSION = '0.1.0ab'

require 'rubygems' unless defined?(Gem)
require 'bundler/setup'

Bundler.require(:default, PADRINO_ENV)

require 'yaml'

if defined?(LogBuddy)
  LogBuddy.init({
    :logger => logger,
    :disabled => PADRINO_ENV == :production
  })
end

if File.exists?(Padrino.root('.config.yml'))
  CONFIG = YAML.load_file(Padrino.root('.config.yml'))
else
  CONFIG = nil
end

I18n.default_locale = :en

Padrino.load!
