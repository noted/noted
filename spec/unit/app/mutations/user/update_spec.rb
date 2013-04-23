require 'spec_helper'

describe User::Update do
  let(:user) do
    create(:user)
  end

  let(:action) do
    User::Update.run({
      :user => {
        :id => user.id.to_s,
        :name => 'Neil deGrasse Tyson'
      }
    })
  end

  before do
    user.reload
  end

  it { action.success?.should be_true }
  it { action.result.should be_an_instance_of User }
  it { action.result.name.should eql 'Neil deGrasse Tyson' }
  it { action.result.name.should eql user.name }
end
