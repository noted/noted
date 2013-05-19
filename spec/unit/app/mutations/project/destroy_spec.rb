require 'spec_helper'

describe Project::Destroy do
  let(:project) { create(:project) }
  let(:user)    { project.user }

  let(:action) do
    Project::Destroy.run({
      :author => user.id.to_s,
      :project => {
        :id => project.id.to_s,
      }
    })
  end

  it { action.success?.should be_true }
end
