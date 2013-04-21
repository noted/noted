source 'https://rubygems.org'

%w(cache core gen helpers).each do |c|
  gem 'padrino-' + c, '0.11.1'
end

gem 'puma', '2.0.0.b7'

gem 'rake'

gem 'bson_ext'
gem 'mongo_mapper'

gem 'memcached'

gem 'redis'

gem 'canable'
gem 'state_machine'

gem 'von'

gem 'bcrypt-ruby'
gem 'base32-crockford', require: 'base32/crockford'

gem 'scholar', git: 'https://github.com/noted/scholar.git'

gem 'mutations'

gem 'padrino-sprockets', require: 'padrino/sprockets'

gem 'haml'
gem 'redcarpet'

gem 'sprockets-sass'
gem 'compass'
gem 'susy'

gem 'coffee-script'

gem 'jsmin'
gem 'yui-compressor'

group :development, :test do
  gem 'better_errors'
  gem 'binding_of_caller'

  gem 'log_buddy'
end

group :development, :production do
  gem 'execjs'
end

group :development do
  gem 'foreman'
  gem 'pry'
end

group :production do
  gem 'therubyracer'
  gem 'cijoe', :git => 'https://github.com/nvloff/cijoe.git'
end

group :test do
  gem 'rack-test', require: 'rack/test'

  gem 'rspec'
  gem 'shoulda-matchers'

  gem 'mocha', require: 'mocha/api'
  gem 'capybara', require: 'capybara/dsl'

  gem 'spork', '1.0.0rc3'
  gem 'factory_girl'
  gem 'database_cleaner'

  gem 'rubocop'
  gem 'cane'
end
