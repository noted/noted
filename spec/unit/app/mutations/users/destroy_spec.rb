require 'spec_helper'

describe UserCreate do
  let(:user) do
    create(:user)
  end

  let(:action) do
    UserDestroy.run({:id => user.id})
  end

  it { action.success?.should be_true }
end
