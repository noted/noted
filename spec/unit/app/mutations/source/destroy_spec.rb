require 'spec_helper'

describe Source::Destroy do
  let(:user)   { create(:user) }
  let(:source) { create(:source) }

  let(:action) do
    Source::Destroy.run({
      :author => user.id.to_s,
      :source => {
        :id => source.id.to_s
      }
    })
  end

  it { action.success?.should be_true }
end
