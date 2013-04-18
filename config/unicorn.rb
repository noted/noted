# unicorn -c /var/www/noted/noted/config/unicorn.rb -E production -D

padrino_env  = ENV['RACK_ENV'] || 'production'
padrino_root = File.expand_path('../..', __FILE__)

# 16 workers and 1 master
worker_processes (padrino_env == 'production' ? 4 : 1)

# Load noted.git into the master before forking workers
# for super-fast worker spawn times
preload_app true

# Restart any workers that haven't responded in 30 seconds
timeout 30

# Store the PID
pid File.join(padrino_root, 'tmp', 'pids', 'unicorn.pid')

# Where to listen
if padrino_env == 'production'
  # Listen on a Unix data socket in production
  #listen File.join(padrino_root, 'tmp', 'sockets', 'unicorn.sock'), :backlog => 2048
  listen 80
else
  # Listen on port 5000 in development
  listen 5000
end

# Log stuff here
if padrino_env == 'production'
  stderr_path File.join(padrino_root, 'log', 'unicorn.stderr.log')
  stdout_path File.join(padrino_root, 'log', 'unicorn.stderr.log')
end


before_fork do |server, worker|
  ##
  # When sent a USR2, Unicorn will suffix its pidfile with .oldbin and
  # immediately start loading up a new version of itself (loaded with a new
  # version of our app). When this new Unicorn is completely loaded
  # it will begin spawning workers. The first worker spawned will check to
  # see if an .oldbin pidfile exists. If so, this means we've just booted up
  # a new Unicorn and need to tell the old one that it can now die. To do so
  # we send it a QUIT.
  #
  # Using this method we get 0 downtime deploys.

  old_pid = File.join(padrino_root, 'tmp', 'pids', 'unicorn.pid.old')
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end


after_fork do |server, worker|
  ##
  # Unicorn master loads the app then forks off workers - because of the way
  # Unix forking works, we need to make sure we aren't using any of the parent's
  # sockets, e.g. db connection

  # Redis and Memcached would go here but their connections are established
  # on demand, so the master never opens a socket


  ##
  # Unicorn master is started as root, which is fine, but let's
  # drop the workers to git:git
=begin
  begin
    uid, gid = Process.euid, Process.egid
    user, group = 'git', 'git'
    target_uid = Etc.getpwnam(user).uid
    target_gid = Etc.getgrnam(group).gid
    worker.tmp.chown(target_uid, target_gid)
    if uid != target_uid || gid != target_gid
      Process.initgroups(user, target_gid)
      Process::GID.change_privilege(target_gid)
      Process::UID.change_privilege(target_uid)
    end
  rescue => e
    if RAILS_ENV == 'development'
      STDERR.puts "couldn't change user, oh well"
    else
      raise e
    end
  end
=end
end
