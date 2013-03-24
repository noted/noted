require 'spec_helper'

describe Source::Destroy do
  let(:user)   { create(:user) }
  let(:source) { create(:source) }

  let(:action) do
    Source::Destroy.run({
      :source => {
        :id => source.id,
        :author => user.id
      }
    })
  end

  it { action.success?.should be_true }
end
