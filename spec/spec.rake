require 'rspec/core/rake_task'

spec_tasks = Dir['spec/unit/*/'].map { |d| File.basename(d) }

spec_tasks.each do |folder|
  RSpec::Core::RakeTask.new("spec:#{folder}") do |t|
    t.pattern = "./spec/unit/#{folder}/**/*_spec.rb"
    t.rspec_opts = %w(--format Fuubar --color --drb)
  end
end

desc 'Run complete application spec suite'
task 'spec' => spec_tasks.map { |f| "spec:#{f}" }
