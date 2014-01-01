require 'spec_helper'

describe Project do
  let(:project)  { create :project }
  let(:user)     { project.user }
  let(:outsider) { create :user }

  it { expect(project).to be_valid }

  it { expect(project).to validate_presence_of :title }

  describe '#permalink!' do
    it { expect(project.permalink).to include 'the-cosmos' }
  end

  describe '#viewable_by?' do
    it { expect(project.viewable_by?(user)).to eql true }
    it { expect(project.viewable_by?(outsider)).to eql true }
  end

  describe '#updatable_by?' do
    it { expect(project.updatable_by?(user)).to eql true }
    it { expect(project.updatable_by?(outsider)).to eql false }
  end

  describe '#destroyable_by' do
    it { expect(project.destroyable_by?(user)).to eql true }
    it { expect(project.destroyable_by?(outsider)).to eql false }
  end
end
