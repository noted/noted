require "spec_helper"

describe Project do
	let(:user) { create(:user) }
  let(:project) { create(:project) }

  it "can be instantiated" do
    project.should_not be_nil
  end

  describe "#permalink!" do
    it "should create a permalink" do
      project.permalink.should_not be_nil
      project.permalink.should == "the-cosmos"
    end
  end
end
