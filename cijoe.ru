require 'rubygems' unless defined?(Gem)
require 'bundler/setup'

require 'cijoe'

use Rack::CommonLogger

CIJoe::Server.configure do |config|
  config.set :project_path, File.dirname(__FILE__)
  config.set :lock, true
end

run Rack::URLMap.new('/' => CIJoe::Server.new)
