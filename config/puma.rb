PADRINO_ENV  = ENV['PADRINO_ENV'] ||= ENV['RACK_ENV'] ||= 'development'  unless defined?(PADRINO_ENV)
PADRINO_ROOT = File.expand_path('../..', __FILE__) unless defined?(PADRINO_ROOT)

require 'fileutils'
require 'yaml'

# Create log/ and tmp/ if in production.
if PADRINO_ENV == 'production'
  directories = [
    File.join(PADRINO_ROOT, 'log'),
    File.join(PADRINO_ROOT, 'tmp'),
    File.join(PADRINO_ROOT, 'tmp', 'pids'),
    File.join(PADRINO_ROOT, 'tmp', 'sockets')
  ]

  directories.each do |d|
    FileUtils.mkdir(d) unless File.exists?(d)
  end
end

# The PADRINO_ROOT to operate out of.
#
# The default is the current PADRINO_ROOT.
#
directory PADRINO_ROOT

# Use a object or block as the rack application. This allows the
# config file to be the application itself.
#
# app do |env|
#   puts env
#
#   body = 'Hello, World!'
#
#   [200, { 'Content-Type' => 'text/plain', 'Content-Length' => body.length.to_s }, [body]]
# end

# Load “path” as a rackup file.
#
# The default is “config.ru”.
#
rackup File.join(PADRINO_ROOT, 'config.ru')

# Set the environment in which the rack's app will run.
#
# The default is “development”.
#
environment = PADRINO_ENV.to_sym

# Daemonize the server into the background. Highly suggest that
# this be combined with “pidfile” and “stdout_redirect”.
#
# The default is “false”.
#
if environment == :production
  daemonize
end

# Store the pid of the server in the file at “path”.
#
pidfile File.join(PADRINO_ROOT, 'tmp', 'pids', 'puma.pid')

# Use “path” as the file to store the server info state. This is
# used by “pumactl” to query and control the server.
#
state_path File.join(PADRINO_ROOT, 'tmp', 'pids', 'puma.state')

# Redirect STDOUT and STDERR to files specified. The 3rd parameter
# (“append”) specifies whether the output is appended, the default is
# “false”.
#
if environment == :production
  stdout = File.join(PADRINO_ROOT, 'log', 'stdout.log')
  stderr = File.join(PADRINO_ROOT, 'log', 'stderr.log')

  stdout_redirect stdout, stderr
end
# stdout_redirect '/u/apps/lolcat/log/stdout', '/u/apps/lolcat/log/stderr', true

# Disable request logging.
#
# The default is “false”. If in development, use Padrino's logger.
#
quiet

# Configure “min” to be the minimum number of threads to use to answer
# requests and “max” the maximum.
#
# The default is “0, 16”.
#
# threads 0, 16

# Bind the server to “url”. “tcp://”, “unix://” and “ssl://” are the only
# accepted protocols.
#
# The default is “tcp://0.0.0.0:9292”.
#
if environment == :production
  #socket = File.join(PADRINO_ROOT, 'tmp', 'sockets', 'puma.sock')

  #bind "unix://#{socket}"

  bind 'tcp://0.0.0.0:80'
else
  bind 'tcp://0.0.0.0:5000'
end
# bind 'tcp://0.0.0.0:9292'
# bind 'unix:///var/run/puma.sock'
# bind 'unix:///var/run/puma.sock?umask=0777'
# bind 'ssl://127.0.0.1:9292?key=path_to_key&cert=path_to_cert'

# Instead of “bind 'ssl://127.0.0.1:9292?key=path_to_key&cert=path_to_cert'” you
# can also use the “ssl_bind” option.
#
# ssl_bind '127.0.0.1', '9292', { key: path_to_key, cert: path_to_cert }

# Code to run before doing a restart. This code should
# close log files, database connections, etc.
#
# This can be called multiple times to add code each time.
#
# on_restart do
#   puts "do something"
# end

# Command to use to restart puma. This should be just how to
# load puma itself (ie. 'ruby -Ilib bin/puma'), not the arguments
# to puma, as those are the same as the original process.
#
# restart_command '/u/app/lolcat/bin/restart_puma'

# === Cluster mode ===

# How many worker processes to run.
#
# The default is “0”.
#
# workers 2

# Code to run when a worker boots to setup the process before booting
# the app.
#
# This can be called multiple times to add hooks.
#
# on_worker_boot do
#   puts 'On worker boot...'
# end

# === Puma control rack application ===

# Start the puma control rack application on “url”. This application can
# be communicated with to control the main server. Additionally, you can
# provide an authentication token, so all requests to the control server
# will need to include that token as a query parameter. This allows for
# simple authentication.
#
# Check out https://github.com/puma/puma/blob/master/lib/puma/app/status.rb
# to see what the app has available.

if environment == :production
  ctlsocket = File.join(PADRINO_ROOT, 'tmp', 'sockets', 'pumactl.sock')

  token = YAML.load_file(File.join(PADRINO_ROOT, '.puma.yml'))['token']

  activate_control_app "unix://#{ctlsocket}", { auth_token: token['token'] }
else
  activate_control_app 'tcp://0.0.0.0:5100', { no_token: true }
end
# activate_control_app 'unix:///var/run/pumactl.sock'
# activate_control_app 'unix:///var/run/pumactl.sock', { auth_token: '12345' }
# activate_control_app 'unix:///var/run/pumactl.sock', { no_token: true }
