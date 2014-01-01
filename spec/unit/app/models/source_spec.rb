require 'spec_helper'

describe Source do
  let(:source)   { create :source }
  let(:user)     { source.project.user }
  let(:outsider) { create :user }

  it { expect(source).to be_valid }

  describe '#citation!' do
    let(:citation) do
      'Poe, Edgar Allen. <i>Poetry, Tales, and Selected Essays</i>. Ed. Patrick F. Quinn and G.R. Thompson. New York: Library of America, 1996. Print.'
    end

    it { expect(source.citation).to eql citation }
  end

  describe '#viewable_by?' do
    it { expect(source.viewable_by?(user)).to eql true }
    it { expect(source.viewable_by?(outsider)).to eql true }
  end

  describe '#updatable_by?' do
    it { expect(source.updatable_by?(user)).to eql true }
    it { expect(source.updatable_by?(outsider)).to eql false }
  end

  describe '#destroyable_by' do
    it { expect(source.destroyable_by?(user)).to eql true }
    it { expect(source.destroyable_by?(outsider)).to eql false }
  end
end
