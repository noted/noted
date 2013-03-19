require 'spec_helper'

describe User::Destroy do
  let(:user) do
    create(:user)
  end

  let(:action) do
    User::Destroy.run({:id => user.id})
  end

  it { action.success?.should be_true }
end
