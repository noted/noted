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

gem 'memcached'

gem 'redis'
gem 'von'

gem 'bcrypt-ruby'
gem 'base32-crockford', require: 'base32/crockford'

gem 'scholar', git: 'https://github.com/noted/scholar.git'

gem 'mutations'

gem 'haml'
gem 'maruku'

gem 'padrino-sprockets', require: 'padrino/sprockets'

gem 'sprockets-sass'
gem 'compass'
gem 'susy'

gem 'coffee-script'

gem 'jsmin'
gem 'yui-compressor'

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
  gem 'unicorn'
  gem 'execjs'
  gem 'therubyracer'
  gem 'cijoe', :git => 'https://github.com/nvloff/cijoe.git'
end

group :test do
  gem 'rack-test', require: 'rack/test'

  gem 'rspec'
  gem 'shoulda-matchers'

  gem 'mocha', require: 'mocha/api'
  gem 'capybara', require: 'capybara/dsl'

  gem 'spork'
  gem 'factory_girl'
  gem 'database_cleaner'

  gem 'rubocop'
  gem 'cane'
end
