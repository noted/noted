Noted::Application.configure do
  # Settings specified here will take precedence over those in config/environment.rb

  # The production environment is meant for finished, "live" apps.
  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local = false
  config.action_controller.perform_caching             = true
  config.action_view.cache_template_loading            = true

  # setup memcachier/dalli (the memcachier gem will tweak this to auth
  # to the right servers based on heroku ENV vars.)
  config.cache_store = :dalli_store

  # The production environment is meant for finished, "live" apps.
  # Code is not reloaded between requests
  config.cache_classes = true

  # Eager load in production
  config.eager_load = true


  # See everything in the log (default is :info)
  # config.log_level = :debug

  # Use a different logger for distributed setups
  # config.logger = SyslogLogger.new

  # Use a different cache store in production
  # config.cache_store = :mem_cache_store

  # Enable serving of images, stylesheets, and javascripts from an asset server
  config.action_controller.asset_host = "http://ssets-staging.workwork.co"

  # Compress JavaScripts and CSS
  config.assets.compress = true
  config.assets.js_compressor = :uglifier
  config.assets.css_compressor = :yui

  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = false

  # Generate digests for assets URLs
  config.assets.digest = true

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false
  config.action_mailer.delivery_method = :smtp

  # Enable threaded mode
  # config.threadsafe!

  # Basic authentication
  config.middleware.insert_after(::ActionDispatch::Static, "::Rack::Auth::Basic", "Rollcall Staging") do |u, p|
    [u, p] == [ENV['HTTP_USER'], ENV['HTTP_PASSWORD']]
  end

end
