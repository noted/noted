require 'spec_helper'

describe User do
  let(:user)     { create :user }
  let(:outsider) { create :user }

  it { expect(user).to be_valid }

  it { expect(user).to validate_presence_of :name }
  it { expect(user).to validate_presence_of :email }
  it { expect(user).to validate_presence_of :username }

  it { expect(user).to validate_uniqueness_of :email }
  it { expect(user).to validate_uniqueness_of :username }

  describe '#viewable_by?' do
    it { expect(user.viewable_by?(user)).to eql true }
    it { expect(user.viewable_by?(outsider)).to eql true }
  end

  describe '#updatable_by?' do
    it { expect(user.updatable_by?(user)).to eql true }
    it { expect(user.updatable_by?(outsider)).to eql false }
  end

  describe '#destroyable_by?' do
    it { expect(user.destroyable_by?(user)).to eql true }
    it { expect(user.destroyable_by?(outsider)).to eql false }
  end
end
