require "helper"
require "rack/test"
require "cijoe/server"

describe CIJoe::Server do
  include Rack::Test::Methods

  class ::CIJoe
    # make Build#restore a no-op so we don't overwrite our current/last
    # build attributes set from tests.
    undef :restore if defined? :restore
    def restore
    end

    # make CIJoe#build! and CIJoe#git_update a no-op so we don't overwrite our local changes
    # or local commits nor should we run tests.
    undef :build! if defined? :build!
    def build!
    end
  end

  def app
    CIJoe::Server.new
  end

  describe 'GET /ping' do
    it 'should work with no build' do
      get "/ping"

      last_response.status.must_equal 412
    end

    it 'responds with the last build sha if the build was ok' do
      last_build = build :worked
      CIJoe.any_instance.stubs(:last_build).returns(last_build)

      get "/ping"

      last_response.status.must_equal 200
      last_response.body.must_equal last_build.sha
    end

    it 'responds with building if the build is in progress' do
      current_build = build :building
      CIJoe.any_instance.stubs(:current_build).returns(current_build)

      get "/ping"

      last_response.status.must_equal 412
      last_response.body.must_equal 'building'
    end

    it 'uses the current build status' do
      last_build = build :worked
      CIJoe.any_instance.stubs(:last_build).returns(last_build)

      current_build = build :building
      CIJoe.any_instance.stubs(:current_build).returns(current_build)
      CIJoe.any_instance.stubs(:building?).returns(true)

      get "/ping"

      last_response.status.must_equal 412
      last_response.body.must_equal 'building'
    end

    it 'responds with non success response if the build failed' do
      last_build = build :failed
      CIJoe.any_instance.stubs(:last_build).returns(last_build)

      get "/ping"

      last_response.status.must_equal 412
      last_response.body.must_equal last_build.sha
    end
  end

  describe 'POST /' do
    it 'works with json' do
      CIJoe.any_instance.expects(:build)

      post '/', :payload => File.read("#{Dir.pwd}/test/fixtures/payload.json")

      last_response.status.must_equal 302
    end

    it 'does not build on branch mismatch' do
      CIJoe.any_instance.expects(:build).never

      post "/", :payload => {"ref" => "refs/heads/dont_build"}.to_json

    end

    it 'builds specific branch when specified' do
      CIJoe.any_instance.expects(:build).with("branchname")

      post "/?branch=branchname", :payload => {"ref" => "refs/heads/master"}.to_json

      last_response.status.must_equal 302
    end

    it 'builds branch on match' do
      CIJoe.any_instance.expects(:build)

      post "/", :payload => {"ref" => "refs/heads/master"}.to_json

      last_response.status.must_equal 302
    end

    it 'builds when the button its used' do
      CIJoe.any_instance.expects(:build)

      post "/", :rebuild => true
      last_response.status.must_equal 302
    end
  end

  describe 'GET /api/json' do
    it 'returns plain json without params' do
      last_build = build :failed
      CIJoe.any_instance.stubs(:last_build).returns(last_build)

      get "/api/json"

      last_response.status.must_equal 200
      last_response.content_type.must_equal 'application/json'
    end

    it 'returns json with param' do
      last_build = build :failed
      CIJoe.any_instance.stubs(:last_build).returns(last_build)

      get "/api/json?jsonp=fooberz"

      last_response.status.must_equal 200
      last_response.content_type.must_equal 'application/json'
      last_response.body.must_match(/^fooberz\(/)
    end
  end

  def build status
    CIJoe::Build.new_from_hash(
      {
        :project_path => 'path',
        :user         => 'user',
        :project      => 'project',
        :started_at   => Time.now,
        :finished_at  => Time.now,
        :sha          => 'deadbeef',
        :status       => status,
        :output       => 'output',
        :pid          => nil
      })
  end
end
