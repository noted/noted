require 'spec_helper'

describe Note do
  let(:note)     { create :note }
  let(:user)     { note.project.user }
  let(:outsider) { create :user }

  it { expect(note).to be_valid }

  it { expect(note).to validate_presence_of :title }

  describe '#viewable_by?' do
    it { expect(note.viewable_by?(user)).to eql true }
    it { expect(note.viewable_by?(outsider)).to eql true }
  end

  describe '#updatable_by?' do
    it { expect(note.updatable_by?(user)).to eql true }
    it { expect(note.updatable_by?(outsider)).to eql false }
  end

  describe '#destroyable_by' do
    it { expect(note.destroyable_by?(user)).to eql true }
    it { expect(note.destroyable_by?(outsider)).to eql false }
  end
end
