require 'sinatra/base'
require 'erb'
require 'json'

class CIJoe
  class Server < Sinatra::Base
    attr_reader :joe

    dir = File.dirname(File.expand_path(__FILE__))

    set :views,  "#{dir}/views"
    set :public_folder, "#{dir}/public"
    set :static, true
    set :lock, true

    before { joe.restore }

    get '/ping' do
      if joe.building? || joe.last_build.nil?
        halt 412, "building"
      elsif !joe.last_build.worked?
        halt 412, joe.last_build.sha
      end

      joe.last_build.sha
    end

    get '/?' do
      @joe = joe

      erb :template, :escape_html => false
    end

    post '/?' do

      unless params[:rebuild]
        payload = JSON.parse(params[:payload])
        pushed_branch = payload["ref"].split('/').last
      end

      # Only build if we were given an explicit branch via `?branch=blah`
      # or the payload exists and the "ref" property matches our
      # specified build branch.
      if params[:branch] || params[:rebuild] || pushed_branch == joe.git.branch
        joe.build(params[:branch])
      end

      redirect request.path
    end

    get '/api/json' do
      response  = [200, {'Content-Type' => 'application/json'}]
      response_json = erb(:json, {}, :joe => joe)
      if params[:jsonp]
        response << params[:jsonp] + '(' +  response_json + ')'
      else
        response << response_json
      end
      response
    end


    helpers do
      include Rack::Utils
      alias_method :h, :escape_html

      # thanks integrity!
      def ansi_color_codes(string)
        string.gsub("\e[0m", '</span>').
          gsub(/\e\[(\d+)m/, "<span class=\"color\\1\">")
      end

      def pretty_time(time)
        time.strftime("%Y-%m-%d %H:%M")
      end

      def cijoe_root
        root = request.path
        root = "" if root == "/"
        root
      end
    end

    def initialize(*args)
      super
      check_project
      @joe = CIJoe.new(settings.project_path)
    end

    def self.start(host, port, project_path)
      set :project_path, project_path
      CIJoe::Server.run! :host => host, :port => port
    end

    def self.rack_start(project_path)
      set :project_path, project_path
      self.new
    end

    def self.project_path=(project_path)
      user, pass = Config.cijoe(project_path).user.to_s, Config.cijoe(project_path).pass.to_s
      if user != '' && pass != ''
        use Rack::Auth::Basic do |username, password|
          [ username, password ] == [ user, pass ]
        end
        puts "Using HTTP basic auth"
      end
      set :project_path, Proc.new{project_path}, true
    end

    def check_project
      if settings.project_path.nil? ||
        !File.exists?(File.expand_path(settings.project_path)) ||
        !File.exists?(File.join(File.expand_path(settings.project_path),'.git'))
        puts "Whoops! I need the path to a Git repo."
        puts "  $ git clone git@github.com:username/project.git project"
        abort "  $ cijoe project"
      end
    end
  end
end
