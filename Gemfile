source :rubygems

ruby '1.9.3'

gem 'padrino', '0.10.7'

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

gem 'scholar', git: 'git://github.com/noted/scholar.git'

gem 'haml'

gem 'compass'
gem 'susy'

gem 'barista'

group :development, :test do
  gem 'log_buddy'
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :development do
  gem 'foreman'
  gem 'execjs'
end

group :test do
  gem 'rack-test', require: 'rack/test'
  
  gem 'rspec'
  gem 'shoulda-matchers'
  gem 'autotest'
  gem 'fuubar'

  gem 'mocha', require: 'mocha/api'
  gem 'capybara', require: 'capybara/dsl'

  gem 'spork'
  gem 'factory_girl'
end