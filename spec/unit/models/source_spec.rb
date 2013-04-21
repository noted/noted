require "spec_helper"

describe Source do
  let(:source)  { create(:source) }
  let(:project) { source.project }
  let(:user)     { project.user }
  let(:staff)    { create(:user, :staff) }
  let(:outsider) { create(:user) }
  let(:collaborator) do
    u = create(:user)

    project.collaborator_ids << u.id
    project.save

    u
  end

  it "can be instantiated" do
    source.should be_valid
  end

  describe "#url" do
    it { source.url.should eql("/#{user.username}/#{project.permalink}/sources/#{source.permalink}")}
  end

  describe "#permalink!" do
    it { source.permalink.should eql((Base32::Crockford.encode(Von.count('sources').total))) }
  end

  describe "#creatable_by?" do
    it { source.creatable_by?(user).should be_true }
    it { source.creatable_by?(collaborator).should be_true }
    it { source.creatable_by?(outsider).should be_false }
    it { source.creatable_by?(staff).should be_true }
  end

  describe "#updatable_by?" do
    it { source.updatable_by?(user).should be_true }
    it { source.updatable_by?(collaborator).should be_true }
    it { source.updatable_by?(outsider).should be_false }
    it { source.updatable_by?(staff).should be_true }
  end

  describe "#destroyable_by?" do
    it { source.destroyable_by?(user).should be_true }
    it { source.destroyable_by?(collaborator).should be_true }
    it { source.destroyable_by?(outsider).should be_false }
    it { source.destroyable_by?(staff).should be_true }
  end
end
