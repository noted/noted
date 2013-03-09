source 'https://rubygems.org'

%w{cache core gen helpers}.each do |p|
  gem "padrino-#{p}", '0.10.7'
end

gem 'puma'

gem 'rake'
gem 'sinatra-flash', require: 'sinatra/flash'

gem 'bson_ext', require: 'mongo'
gem 'mongo_mapper'

gem 'canable'

gem 'state_machine'

gem 'redis'

gem 'bcrypt-ruby'
gem 'base32-crockford', require: 'base32/crockford'

gem 'haml'

gem 'maruku'

gem 'compass'
gem 'susy'

gem 'barista'

gem 'log_buddy'

group :development, :test do
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :development do
  gem 'foreman'
  gem 'execjs'
  gem 'pry'
end

group :test do
  gem 'rack-test', require: 'rack/test'

  gem 'rspec'
  gem 'shoulda-matchers'
  gem 'fuubar'

  gem 'mocha', require: 'mocha/api'
  gem 'capybara', require: 'capybara/dsl'

  gem 'spork'
  gem 'factory_girl'
  gem 'database_cleaner'

  gem 'cane'
end
