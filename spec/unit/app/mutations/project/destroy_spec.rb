require 'spec_helper'

describe Project::Destroy do
  let(:project) { create(:project) }

  let(:action) do
    Project::Destroy.run({
      :project => project.id,
    })
  end

  it { action.success?.should be_true }
end
