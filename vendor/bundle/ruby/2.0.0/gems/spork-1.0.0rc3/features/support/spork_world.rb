require 'forwardable'
require 'fileutils'
require 'tempfile'
require 'pathname'

class SporkWorld
  SPORK_ROOT    = Pathname.new(File.expand_path('../../', File.dirname(__FILE__)))
  RUBY_BINARY   = File.join(Config::CONFIG['bindir'], Config::CONFIG['ruby_install_name'])
  BINARY        = SPORK_ROOT + 'bin/spork'

  extend Forwardable
  def_delegators SporkWorld, :sandbox_dir, :spork_lib_dir

  def spork_lib_dir
    @spork_lib_dir ||= File.expand_path(File.join(File.dirname(__FILE__), '../../lib'))
  end

  def initialize
    @current_dir = SANDBOX_DIR
    @background_jobs = []
  end

  private
  attr_reader :last_exit_status, :last_stderr, :last_stdout, :background_jobs
  def last_stderr
    return @last_stderr if @last_stderr
    if @background_job
      @last_stderr = @background_job.stderr.read
    end
  end


  def last_stdout
    return @last_stdout if @last_stdout
    if @background_job
      @last_stdout = @background_job.stdout.read
    end
  end

  def create_file(file_name, file_content)
    file_content.gsub!("SPORK_LIB", "'#{spork_lib_dir}'") # Some files, such as Rakefiles need to use the lib dir
    in_current_dir do
      FileUtils.mkdir_p(File.dirname(file_name))
      File.open(file_name, 'w') { |f| f << file_content }
    end
  end

  def in_current_dir(&block)
    Dir.chdir(@current_dir, &block)
  end

  def run(command)
    stderr_file = Tempfile.new('spork')
    stderr_file.close
    in_current_dir do
      @last_stdout = `env RUBYOPT= bundle exec #{command} 2> #{stderr_file.path}`
      @last_exit_status = $?.exitstatus
    end
    @last_stderr = IO.read(stderr_file.path)
  end

  def run_in_background(command)
    in_current_dir do
      @background_job = BackgroundJob.run("env RUBYOPT= bundle exec " +  command)
    end
    @background_jobs << @background_job
    @background_job
  end

  def terminate_background_jobs
    if @background_jobs
      @background_jobs.each do |background_job|
        background_job.kill
      end
    end
    @background_jobs.clear
    @background_job = nil
  end

  def reset_sandbox_dir
    FileUtils.rm_rf SANDBOX_DIR
    FileUtils.mkdir_p SANDBOX_DIR
  end
end
