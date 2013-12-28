ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)

require 'rspec/rails'
require 'rspec/autorun'

RSpec.configure do |conf|
  conf.include FactoryGirl::Syntax::Methods
end
