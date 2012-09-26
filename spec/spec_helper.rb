require 'spork'

PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)

Spork.prefork do
  require File.expand_path(File.dirname(__FILE__) + "/../config/boot")

  FactoryGirl.find_definitions

  RSpec.configure do |conf|
    conf.include Rack::Test::Methods
    conf.include Capybara::DSL
    conf.include FactoryGirl::Syntax::Methods

    conf.mock_with :mocha

    conf.after do # This is slightly messy. Mock/stub instead?
      MongoMapper.database.collections.each do |c|
        c.remove
      end
    end
  end

  def app
    Padrino.application
  end

  def response
    last_response
  end
end
