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

    Capybara.app = Padrino.application
  end

  def app
    Padrino.application
  end

  def response
    last_response
  end

  def site
    "http://example.org"
  end

  class Data
    class << self
      def book
        {
          :attributes => {
            :type => "book",
            :title => "The Hitchhiker's Guide to the Galaxy",
            :contributors => [
              {
                :type => "author",
                :first => "Douglas",
                :last => "Adams"
              }
            ],
            :publisher => {
              :name => "Ballantine",
              :location => "New York"
            },
            :year => "2005"
          }
        }
      end
    end
  end
end
