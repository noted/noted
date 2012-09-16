PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)

Spork.prefork do
  require File.expand_path(File.dirname(__FILE__) + "/../config/boot")

  RSpec.configure do |conf|
    conf.include Rack::Test::Methods
    conf.include Capybara::DSL

    conf.mock_with :mocha
  end

  def app
    Padrino.application
  end
end

Spork.each_run do
  # Things that need to run each time...
end