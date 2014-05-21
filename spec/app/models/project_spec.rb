require 'spec_helper'

describe Project do
  let(:project)      { create :project }
  let(:owner)        { project.owner }
  let(:collaborator) { project.users.last }
  let(:outsider)     { create :user }

  it { expect(project).to be_valid }

  it { expect(project).to validate_presence_of :title }

  describe '#valid_permalink?' do
    before do
      project.permalink = project.permalink
      project.save
    end

    it { expect(project.errors.messages.keys).to include :permalink  }
  end

  describe '#permalink!' do
    before do
      project.permalink = nil
      project.save
    end

    it { expect(project.permalink).to include 'the-cosmos' }
  end

  describe '#viewable_by?' do
    it { expect(project.viewable_by?(owner)).to eql true }
    it { expect(project.viewable_by?(collaborator)).to eql true }
    it { expect(project.viewable_by?(outsider)).to eql true }
  end

  describe '#updatable_by?' do
    it { expect(project.updatable_by?(owner)).to eql true }
    it { expect(project.updatable_by?(collaborator)).to eql false }
    it { expect(project.updatable_by?(outsider)).to eql false }
  end

  describe '#destroyable_by' do
    it { expect(project.destroyable_by?(owner)).to eql true }
    it { expect(project.destroyable_by?(collaborator)).to eql false }
    it { expect(project.destroyable_by?(outsider)).to eql false }
  end

  describe '#path' do
    context 'without arguments' do
      it { expect(project.path).to eql "/#{owner.username}/#{project.permalink}" }
    end

    context 'with arguments' do
      it { expect(project.path('/foobar')).to eql "/#{owner.username}/#{project.permalink}/foobar" }
    end
  end

  describe '#owner' do
    it { expect(project.owner.id).to eql project.owner_id }
  end

  describe '#owner=' do
    before do
      project.owner = outsider
      project.save
    end

    it { expect(project.owner).to eql outsider }
  end
end
