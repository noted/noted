require "spec_helper"

describe Project do
	let(:user)    { create(:user) }
  let(:project) { create(:project) }

  it "can be instantiated" do
    project.should be_valid
  end

  describe "#permalink!" do
    subject { project.permalink }

    it { should_not be_nil }
    it { should == "the-cosmos"}
  end
end
