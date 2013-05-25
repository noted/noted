##
# CI Joe.
# Because knowing is half the battle.
#
# This is a stupid simple CI server. It can build one (1)
# git-based project only.
#
# It only remembers the last build.
#
# It only notifies to Campfire.
#
# It's a RAH (Real American Hero).
#
# Seriously, I'm gonna be nuts about keeping this simple.

require 'cijoe/version'
require 'cijoe/config'
require 'cijoe/commit'
require 'cijoe/build'
require 'cijoe/campfire'
require 'cijoe/server'
require 'cijoe/queue'
require 'cijoe/git'

class CIJoe
  attr_reader :user, :project, :url, :current_build, :last_build, :campfire, :git

  def initialize(project_path)
    @project_path = File.expand_path(project_path)

    @git = Git.new(@project_path)

    @user, @project = @git.user_and_project
    @url = "http://github.com/#{@user}/#{@project}"

    @campfire = CIJoe::Campfire.new(project_path)

    @last_build = nil
    @current_build = nil
    @queue = Queue.new(!repo_config.buildqueue.to_s.empty?, true)

    trap("INT") { stop }
  end

  # is a build running?
  def building?
    !!@current_build
  end

  # the pid of the running child process
  def pid
    building? and current_build.pid
  end

  # kill the child and exit
  def stop
    Process.kill(9, pid) if pid
    exit!
  end

  # build callbacks
  def build_failed(output, error)
    finish_build :failed, "#{error}\n\n#{output}"
    run_hook("build-failed", @last_build)
  end

  def build_worked(output)
    finish_build :worked, output
    run_hook("build-worked", @last_build)
  end

  def finish_build(status, output)
    @current_build.finished_at = Time.now
    @current_build.status = status
    @current_build.output = output
    write_build 'last', @current_build
    @last_build = @current_build

    @current_build = nil
    @campfire.notify(@last_build) if @campfire.valid?

    build(@queue.next_branch_to_build) if @queue.waiting?
  end

  # run the build but make sure only one is running
  # at a time (if new one comes in we will park it)
  def build(branch=nil)
    if building?
      @queue.append_unless_already_exists(branch)
      # leave anyway because a current build runs
      return
    end
    @current_build = Build.new_from_hash({
      :project_path => @project_path,
      :user         => @user,
      :project      => @project,
    })

    Thread.new { build!(branch) }
  end

  def open_pipe(cmd)
    read, write = IO.pipe

    pid = fork do
      read.close
      $stdout.reopen write
      exec cmd
    end

    write.close

    yield read, pid
  end

  # update git then run the build
  def build!(branch=nil)
    build = @current_build
    output = ''

    @git.update
    run_hook("after-reset", @last_build)

    build.branch = branch || @git.branch
    build.sha = @git.branch_sha build.branch

    open_pipe("cd #{@project_path} && #{runner_command} 2>&1") do |pipe, pid|
      puts "#{Time.now.to_i}: Building #{build.branch} at #{build.short_sha}: pid=#{pid}"

      build.pid = pid
      output = pipe.read
    end

    Process.waitpid(build.pid, 1)
    status = $?.exitstatus.to_i
    @current_build = build
    puts "#{Time.now.to_i}: Built #{build.short_sha}: status=#{status}"

    status == 0 ? build_worked(output) : build_failed('', output)
  rescue Object => e
    puts "Exception building: #{e.message} (#{e.class})"
    build_failed('', e.to_s)
  end

  # shellin' out
  def runner_command
    runner = repo_config.runner.to_s
    runner == '' ? "rake -s test:units" : runner
  end

  # message our repo
  def run_hook(hook, build)
    return unless file = hook_path(hook)

    data =
      if build && build.commit
        {
          "MESSAGE" => build.commit.message,
          "AUTHOR" => build.commit.author,
          "SHA" => build.commit.sha,
          "OUTPUT" => build.env_output
        }
      else
        {}
      end

    orig_ENV = ENV.to_hash
    ENV.clear
    data.each{ |k, v| ENV[k] = v }
    output = `cd #{@project_path} && sh #{file}`

    ENV.clear
    orig_ENV.to_hash.each{ |k, v| ENV[k] = v}
    output
  end

  # restore current / last build state from disk.
  def restore
    @last_build = read_build('last')

    Process.kill(0, @current_build.pid) if @current_build && @current_build.pid
  rescue Errno::ESRCH
    # build pid isn't running anymore. assume previous
    # server died and reset.
    @current_build = nil
  end

  def path_in_project(path)
    File.join(@project_path, path)
  end

  # write build info for build to file.
  def write_build(name, build)
    @git.tag(build.sha, name)
    @git.note(name, build.dump)
  end

  def repo_config
    Config.cijoe(@project_path)
  end

  # load build info from file.
  def read_build(name)
    sha = @git.tag_sha(name)
    Build.parse(@git.note_message(name), @project_path) unless sha.nil?
  end

  private
  def hook_path(hook)
    [ "hooks/#{hook}", ".git/hooks/#{hook}"].map{ |path| path_in_project(path) }.select do |file|
      File.exists?(file) && File.executable?(file)
    end.first
  end

end
