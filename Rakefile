require 'bundler/setup'
require 'padrino-core/cli/rake'
require 'rspec/core/rake_task'

PadrinoTasks.use(:database)
PadrinoTasks.use(:mongomapper)

PadrinoTasks.init

RSpec::Core::RakeTask.new(:spec)

task :default => :spec
