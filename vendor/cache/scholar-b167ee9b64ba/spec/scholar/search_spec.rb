require 'spec_helper'

describe Scholar::Search do
  before do
    VCR.insert_cassette 'search', :record => :all
  end

  let(:search) do
    Scholar::Search.new("foobar")
  end

  describe ".new" do
    it { search.query.should eql "foobar" }
    it { search.results.should be_an_instance_of Array }
    it { search.results[0].should be_an_instance_of Scholar::Citation }
  end

  describe "#to_hash" do
    it { search.to_hash.keys.should =~ [:query, :results] }
    it { search.to_hash[:results][0].should be_an_instance_of Hash }
  end

  after do
    VCR.eject_cassette
  end
end
