require 'helper'

describe CIJoe::Build do

  def setup
    @time_now =  Time.utc(2007,11,1,15,25)
    @build = CIJoe::Build.new_from_hash(
      {
        :project_path => 'path',
        :user         => 'user',
        :project      => 'project',
        :started_at   =>  @time_now,
        :sha          => 'deadbeef',
        :status       => :success,
        :output       => 'output',
        :pid          => nil
      })
  end

  describe '.new_from_hash' do
    it 'can be created from hash' do
      build = CIJoe::Build.new_from_hash :sha => 'deadbeef'
      build.sha.must_equal 'deadbeef'
    end

    it 'raises excepton on extra fields' do
      lambda { CIJoe::Build.new_from_hash :illegal => 'deadbeef'}.must_raise(RuntimeError, ArgumentError)
    end
  end

  describe 'save/restore' do
    it 'stores a build and restores it with correct timestamp' do
      json = @build.dump
      parsed = CIJoe::Build.parse(json, 'path')

      parsed.started_at.must_equal @build.started_at
      parsed.sha.must_equal @build.sha
    end
  end

end
