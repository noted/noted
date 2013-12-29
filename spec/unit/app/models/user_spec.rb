require 'spec_helper'

describe User do
  let(:user) { create :user }

  it { expect(user).to be_valid }

  it { expect(user).to validate_presence_of :name }
  it { expect(user).to validate_presence_of :email }
  it { expect(user).to validate_presence_of :username }

  it { expect(user).to validate_uniqueness_of :email }
  it { expect(user).to validate_uniqueness_of :username }
end
