require 'spec_helper'

describe Password::Reset do
  let(:user) { create(:user) }
  let(:action) do
    Password::Reset.run({
      :user => {
        :id => user.id.to_s,
      }
    })
  end

  it { action.success?.should be_true }
  it { action.result.should be_an_instance_of Mail::Message }
  it { action.result.body.should include user.token }
end
