require 'spork'

PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)

Spork.prefork do
  unless ENV['DRB']
    require 'simplecov'
    require 'coveralls'

    SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
      SimpleCov::Formatter::HTMLFormatter,
      Coveralls::SimpleCov::Formatter
    ]

    SimpleCov.start do
      add_filter '/vendor/'
    end
  end

  require File.expand_path(File.dirname(__FILE__) + '/../config/boot')

  FactoryGirl.find_definitions

  RSpec.configure do |conf|
    conf.include Rack::Test::Methods
    conf.include Capybara::DSL
    conf.include FactoryGirl::Syntax::Methods

    conf.before :suite do
      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.clean_with(:truncation)
    end

    conf.before do
      DatabaseCleaner.start
    end

    conf.after do
      DatabaseCleaner.clean

      Von.connection.flushdb
    end

    Capybara.app = Padrino.application
  end

  def app
    Padrino.application
  end

  def response
    last_response
  end

  def site
    'http://example.org'
  end
end

Spork.each_run do
  if ENV['DRB']
    require 'simplecov'
    require 'coveralls'

    SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
      SimpleCov::Formatter::HTMLFormatter,
      Coveralls::SimpleCov::Formatter
    ]

    SimpleCov.start
  end
end
