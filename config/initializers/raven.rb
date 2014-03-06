require 'raven'

if Rails.env == 'production' && ENV['RAVEN_DSN'] != nil
  Raven.configure do |config|
    config.dsn = ENV['RAVEN_DSN']
  end
end