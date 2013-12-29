ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)

require 'rspec/rails'
require 'rspec/autorun'

RSpec.configure do |conf|
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
  end
end
