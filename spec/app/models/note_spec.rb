require 'spec_helper'

describe Note do
  let(:note)         { create :note }
  let(:owner)        { note.project.owner }
  let(:collaborator) { note.project.users.last }
  let(:outsider)     { create :user }

  it { expect(note).to be_valid }

  it { expect(note).to validate_presence_of :title }

  describe '#creatable_by?' do
    it { expect(note.creatable_by?(owner)).to eql true }
    it { expect(note.creatable_by?(collaborator)).to eql true }
    it { expect(note.creatable_by?(outsider)).to eql false }
  end

  describe '#viewable_by?' do
    it { expect(note.viewable_by?(owner)).to eql true }
    it { expect(note.viewable_by?(collaborator)).to eql true }
    it { expect(note.viewable_by?(outsider)).to eql true }
  end

  describe '#updatable_by?' do
    it { expect(note.updatable_by?(owner)).to eql true }
    it { expect(note.updatable_by?(collaborator)).to eql true }
    it { expect(note.updatable_by?(outsider)).to eql false }
  end

  describe '#destroyable_by' do
    it { expect(note.destroyable_by?(owner)).to eql true }
    it { expect(note.destroyable_by?(collaborator)).to eql true }
    it { expect(note.destroyable_by?(outsider)).to eql false }
  end
end
