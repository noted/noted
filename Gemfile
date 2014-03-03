source 'https://rubygems.org'
source 'https://rails-assets.org'

ruby '2.0.0'

gem 'rails', '4.0.2'

gem 'mongoid', '4.0.0.alpha1'

gem 'puma'

gem 'turbolinks'

gem 'mutations'

gem 'canable'
gem 'devise'

gem 'mongoid-history'
gem 'public_activity'

gem 'rails_admin'

gem 'citeproc-ruby'

gem 'haml-rails'

gem 'asset_sync'

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
  gem 'sentry-raven', git: 'https://github.com/getsentry/raven-ruby.git'
end

group :test do
  gem 'rspec-rails', '3.0.0.beta1'

  gem 'shoulda-matchers'
  gem 'factory_girl_rails'

  gem 'database_cleaner'
end
