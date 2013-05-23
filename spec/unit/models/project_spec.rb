require 'spec_helper'

describe Project do
  let(:project)  { create(:project) }
  let(:user)     { project.user }
  let(:outsider) { create(:user) }
  let(:staff)    { create(:user, :staff) }
  let(:collaborator) do
    u = create(:user)

    project.collaborator_ids << u.id.to_s
    project.save

    u
  end

  it { validate_presence_of :title }
  it { validate_presence_of :permalink }

  it { project.should be_valid }

  describe '#collaborators' do
    before do
      project.collaborator_ids << outsider.id
    end

    it { project.collaborators.should include(outsider) }
  end

  describe '#url' do
    it { project.url.should eql("/#{project.user.username}/#{project.permalink}") }
  end

  describe '#permalink!' do
    it { project.permalink.should include('the-cosmos') }
  end

  describe '#updatable_by?' do
    it { project.updatable_by?(user).should be_true }
    it { project.updatable_by?(collaborator).should be_true }
    it { project.updatable_by?(outsider).should be_false }
    it { project.updatable_by?(staff).should be_true }
  end

  describe '#destroyable_by?' do
    it { project.destroyable_by?(user).should be_true }
    it { project.destroyable_by?(collaborator).should be_true }
    it { project.destroyable_by?(outsider).should be_false }
    it { project.destroyable_by?(staff).should be_true }
  end
end
