require 'simplecov'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]

SimpleCov.start

require 'spork'

Spork.prefork do
  require 'rspec'
  require 'vcr'
  require 'webmock/rspec'

  require 'factory_girl'

  require 'log_buddy'

  require_relative '../lib/scholar'

  FactoryGirl.find_definitions

  RSpec.configure do |c|
    c.include FactoryGirl::Syntax::Methods
  end

  VCR.configure do |c|
    c.configure_rspec_metadata!

    c.cassette_library_dir = 'spec/cassettes'
    c.default_cassette_options = { :record => :new_episodes }
    c.hook_into :webmock
  end
end
