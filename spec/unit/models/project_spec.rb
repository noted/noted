require "spec_helper"

describe Project do
  let(:user)    { create(:user) }
  let(:project) { create(:project) }

  it { validate_presence_of :title }
  it { validate_presence_of :permalink }

  it "can be instantiated" do
    project.should be_valid
  end

  describe "#create_permalink!" do
    subject { project.permalink }

    it { should_not be_nil }
    it { should eql("the-cosmos") }
  end
end
