require 'helper'

describe 'hooks' do
  def setup
    @path = File.join(TEST_DIR, (File.join('fixtures', 'testrepo.git', '.')))
    @cijoe = CIJoe.new(@path)

    @build = CIJoe::Build.new_from_hash(
      {
        :project_path => @path,
        :user         => 'user',
        :project      => 'project',
        :started_at   => Time.now,
        :sha          => 'HEAD',
        :status       => :success,
        :output       => 'output',
        :pid          => nil
      })
  end

  it 'leaves the env intact' do
    ENV['AUTHOR'] = 'foo'
    @cijoe.run_hook("test_env", @build)

    ENV.size.wont_equal 0, 'ENV is empty but should not be'
    ENV['AUTHOR'].must_equal 'foo', 'ENV munged a value'
  end

  it 'works with empty env' do
    ENV["test"] = 'should not be shown'
    output = @cijoe.run_hook("test_env", @build)

    output.must_equal "\nNikolai Vladimirov <nikolay@vladimiroff.com>\n"
  end

  it 'has isolated env' do
    ENV['test'] = 'bar'
    output = @cijoe.run_hook("test_env", @build)

    output.wont_include 'bar'
    ENV['test'].must_equal 'bar'
  end
end
