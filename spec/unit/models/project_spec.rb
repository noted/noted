require "spec_helper"

describe Project do
  let(:user)    { create(:user) }
  let(:project) { create(:project) }

  let(:other) { create(:user) }

  it { validate_presence_of :title }
  it { validate_presence_of :permalink }

  it { project.should be_valid }

  describe "#add_collaborator" do
    before do
      project.add_collaborator(other)
    end

    it { project.collaborators.should include(other) }
  end

  describe "#url" do
    it { project.url.should eql("/#{user.username}/#{project.permalink}") }
  end

  describe "#permalink!" do
    it { project.permalink.should eql("the-cosmos") }
  end
end
