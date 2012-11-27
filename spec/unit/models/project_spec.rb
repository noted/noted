require "spec_helper"

describe Project do
	let(:user)    { create(:user) }
  let(:project) { create(:project) }

  it { validate_presence_of :title }
  it { validate_presence_of :permalink }

  it "can be instantiated" do
    project.should be_valid
  end

  describe "#permalink!" do
    subject { project.permalink }

    it { should_not be_nil }
    it { should == "the-cosmos"}

    it "handles duplicate permalinks"
  end

  it "permalink is unique among User's Projects"
end
