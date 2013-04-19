PADRINO_ENV  = ENV['PADRINO_ENV'] ||= ENV['RACK_ENV'] ||= 'development'  unless defined?(PADRINO_ENV)
PADRINO_ROOT = File.expand_path('../../..', __FILE__) unless defined?(PADRINO_ROOT)

namespace :unicorn do

  desc "Start Unicorn server"
  task(:start) do
    c = File.join(PADRINO_ROOT, 'config', 'unicorn.rb')

    sh "bundle exec unicorn --config-file #{c} --env #{PADRINO_ENV} --daemonize"
  end

  desc "Stop Unicorn server"
  task(:stop) do
    signal!(:QUIT)
  end

  desc "Restart Unicorn server"
  task(:restart) do
    signal!(:USR2)
  end

  desc "Increment number of worker processes for Unicorn server"
  task(:increment) do
    signal!(:TTIN)
  end

  desc "Decrement number of worker processes for Unicorn server"
  task(:decrement) do
    signal!(:TTOU)
  end

  desc "Unicorn server pstree"
  task(:pstree) do
    sh "pstree '#{pid?}'"
  end

  def signal!(command)
    Process.kill(command, pid?)
  end

  def pid?
    begin
      File.read(File.join(PADRINO_ROOT, 'tmp', 'pids', 'unicorn.pid')).to_i
    rescue Errno::ENOENT
      raise "Unicorn doesn't seem to be running..."
    end
  end
end
