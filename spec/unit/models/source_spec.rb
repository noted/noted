require "spec_helper"

describe Source do
  let(:source)  { create(:source) }
  let(:project) { source.project }
  let(:user)    { project.user }

  it "can be instantiated" do
    source.should be_valid
  end

  describe "#url" do
    it { source.url.should eql("/#{user.username}/#{project.permalink}/sources/#{source.permalink}")}
  end

  describe "#permalink!" do
    it { source.permalink.should eql(Base32::Crockford.encode(Source.count + 1)) }
  end
end
