require 'helper'

describe CIJoe do

  def setup
    @path = setup_test_repo
    @cijoe = CIJoe.new(@path)

    @build = CIJoe::Build.new(
      {
        :project_path => 'path',
        :user         => 'user',
        :project      => 'project',
        :started_at   => Time.now,
        :sha          => 'HEAD',
        :status       => :success,
        :output       => 'output',
        :pid          => nil
      })

  end

  def teardown
    destroy_repo(@path)
  end

  describe '#write_build' do
    it 'writes a build' do
      @cijoe.write_build('current', @build).must_equal true
    end
  end

  describe '#read_build' do
    it 'works with nonexisting builds' do
      @cijoe.read_build('current').must_be_nil
    end

    it 'reads a build' do
      @cijoe.write_build('current', @build)
      @cijoe.read_build('current').must_be_instance_of CIJoe::Build
    end
  end
end
