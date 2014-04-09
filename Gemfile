source 'https://rubygems.org'

ruby '2.1.1'

gem 'rails', '4.1.0'

gem 'mongoid', '4.0.0.beta1'

gem 'puma'

gem 'turbolinks'

gem 'mutations'

gem 'cache_digests'
gem 'dalli'

gem 'canable'
gem 'devise'

gem 'mongoid-history'
gem 'public_activity'

gem 'mongoid-tags-arent-hard'

gem 'aws-ses', require: 'aws/ses'

gem 'rails_admin', github: 'eturk/rails_admin'

gem 'peek'
gem 'peek-dalli'
gem 'peek-gc'
gem 'peek-git'
gem 'peek-moped'
gem 'peek-performance_bar'
gem 'peek-rblineprof'

gem 'pygments.rb', require: nil

gem 'citeproc-ruby'

gem 'haml-rails'

gem 'asset_sync'
gem 'unf'

gem 'sass-rails', '~> 4.0.0'
gem 'compass-rails'
gem 'susy'

gem 'jquery-rails'

group :assets do
  gem 'coffee-rails', '~> 4.0.0'
  gem 'uglifier', '>= 1.3.0'
end

group :development, :test do
  gem 'rubocop'

  gem 'log_buddy'
end

group :development, :production do
  gem 'pry-rails'
end

group :development do
  gem 'foreman'

  gem 'better_errors'
  gem 'binding_of_caller'
end

group :production do
  gem 'rails_12factor'

  gem 'bugsnag'
end

group :test do
  gem 'rspec-rails', '3.0.0.beta1'

  gem 'minitest' # https://github.com/thoughtbot/shoulda-matchers/issues/408
  gem 'shoulda-matchers'
  gem 'factory_girl_rails'

  gem 'database_cleaner'

  gem 'codeclimate-test-reporter', require: nil
end
