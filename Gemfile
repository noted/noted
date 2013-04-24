source 'https://rubygems.org'

%w(cache core gen helpers).each do |c|
  gem 'padrino-' + c, '0.11.1'
end

gem 'puma', '2.0.0.b7'

gem 'rake', '~> 10.0.4'

gem 'bson_ext', '~> 1.8.5'
gem 'mongo_mapper', '~> 0.12.0'

gem 'memcached', '~> 1.5.0'

gem 'redis', '~> 3.0.4'

gem 'mm-paranoid', git: 'https://github.com/dclausen/mm-paranoid.git'
gem 'canable', '~> 0.3.0'
gem 'state_machine', '~> 1.2.0'

gem 'von', '~> 0.2.0'

gem 'bcrypt-ruby', '~> 3.0.1'
gem 'base32-crockford', '~> 0.1.0', require: 'base32/crockford'

gem 'scholar', git: 'https://github.com/noted/scholar.git'

gem 'mutations', '~> 0.5.12'

gem 'padrino-sprockets', '~> 0.0.2', require: 'padrino/sprockets'

gem 'haml', '~> 4.0.2'
gem 'redcarpet', '~> 2.2.2'

gem 'sprockets-sass', '~> 1.0.0'
gem 'compass', '~> 0.12.2'
gem 'susy', '~> 1.0.8'

gem 'coffee-script', '~> 2.2.0'

gem 'jsmin', '~> 1.0.1'
gem 'yui-compressor', '~> 0.9.6'

group :development, :test do
  gem 'better_errors', '~> 0.8.0'
  gem 'binding_of_caller', '~> 0.7.1'

  gem 'log_buddy', '~> 0.7.0'
end

group :development, :production do
  gem 'execjs', '~> 1.4.0'
end

group :development do
  gem 'foreman', '~> 0.63.0'
  gem 'pry', '~> 0.9.12.1'
end

group :production do
  gem 'cijoe', :git => 'https://github.com/nvloff/cijoe.git'
end

group :test do
  gem 'rack-test', '~> 0.6.2', require: 'rack/test'

  gem 'rspec', '~> 2.13.0'
  gem 'shoulda-matchers', '~> 2.0.0'

  gem 'capybara', '~> 2.1.0', require: 'capybara/dsl'

  gem 'spork', '~> 1.0.0rc3'
  gem 'factory_girl', '~> 4.2.0'
  gem 'database_cleaner', '~> 0.9.1'

  gem 'rubocop', '~> 0.5.0'
  gem 'cane', '~> 2.5.2'
end
