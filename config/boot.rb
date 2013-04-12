PADRINO_ENV  = ENV['PADRINO_ENV'] ||= ENV['RACK_ENV'] ||= 'development'  unless defined?(PADRINO_ENV)
PADRINO_ROOT = File.expand_path('../..', __FILE__) unless defined?(PADRINO_ROOT)

COMMIT = `git show --pretty=%H`.split[0...1].join(' ')
BRANCH = `git rev-parse --abbrev-ref HEAD`

require 'rubygems' unless defined?(Gem)
require 'bundler/setup'

Bundler.require(:default, PADRINO_ENV)

LogBuddy.init({
  :logger => logger,
  :disabled => ENV["HEROKU"] || PADRINO_ENV == :production
})

I18n.default_locale = :en

Padrino.load!
