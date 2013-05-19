require 'spec_helper'

describe Password::Recover do
  let(:user) { create(:user) }
  let(:action) do
    Password::Recover.run({
      :user => {
        :id => user.id.to_s
      },
      :password => {
        :password => '13201',
        :confirm => '13201'
      }
    })
  end

  it { action.success?.should be_true }
  it { action.result.should be_an_instance_of User }
  it { action.result.password.should == '13201' }
end
