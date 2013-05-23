source 'https://rubygems.org'

%w(cache core gen helpers mailer).each do |c|
  gem 'padrino-' + c, '0.11.1'
end

gem 'puma', '2.0.1'

gem 'rake', '~> 10.0.4'

gem 'bson_ext', '~> 1.8.5'
gem 'mongo_mapper', '~> 0.12.0'

gem 'memcached', '~> 1.5.0'

gem 'redis', '~> 3.0.4'

gem 'mm-paranoid', git: 'https://github.com/eturk/mm-paranoid.git'
gem 'canable', '~> 0.3.0'
gem 'state_machine', '~> 1.2.0'

gem 'von', '~> 0.2.0'

gem 'bcrypt-ruby', '~> 3.0.1'
gem 'base32-crockford', '~> 0.1.0', require: 'base32/crockford'

gem 'oj', '~> 2.0.12'

gem 'scholar', git: 'https://github.com/noted/scholar.git'

gem 'mutations', '~> 0.5.12'

gem 'padrino-sprockets', git: 'https://github.com/nightsailer/padrino-sprockets.git', require: 'padrino/sprockets'

gem 'tilt', '1.3.7'

gem 'haml', '~> 4.0.2'
gem 'rabl', '~> 0.8.4'

gem 'sprockets-sass', '~> 1.0.0'
gem 'compass', '~> 0.12.2'
gem 'susy', '~> 1.0.8'
gem 'zurb-foundation', '~> 4.1.6'

gem 'coffee-script', '~> 2.2.0'

gem 'uglifier', '~> 2.0.1'
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
  gem 'pry', '~> 0.9.12.2'
end

group :production do
  gem 'therubyracer', '~> 0.11.4'
  gem 'cijoe', :git => 'https://github.com/eturk/cijoe.git'
  gem 'sentry-raven', '~> 0.4.6'
end

group :test do
  gem 'rack-test', '~> 0.6.2', require: 'rack/test'

  gem 'rspec', '~> 2.13.0'
  gem 'shoulda-matchers', '~> 2.1.0'

  gem 'capybara', '~> 2.1.0', require: 'capybara/dsl'

  gem 'spork', '~> 1.0.0rc3'
  gem 'factory_girl', '~> 4.2.0'
  gem 'database_cleaner', '~> 1.0.1'

  gem 'rubocop', '~> 0.7.2'
  gem 'coveralls', '~> 0.6.7'

  gem 'fuubar', '~> 1.1.0'
end
