source 'https://rubygems.org'

%w(cache core gen helpers).each do |c|
  gem 'padrino-' + c, '0.11.1'
end

gem 'puma'

gem 'rake'

gem 'bson_ext'
gem 'mongo_mapper'

gem 'canable'
gem 'state_machine'

gem 'redis'
gem 'von'

gem 'bcrypt-ruby'
gem 'base32-crockford', require: 'base32/crockford'

gem 'scholar', git: 'https://github.com/noted/scholar.git'

gem 'mutations'

gem 'haml', '4.0.1'
gem 'maruku'

gem 'erubis'

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

group :production do
  gem 'execjs'
  gem 'therubyracer'
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
