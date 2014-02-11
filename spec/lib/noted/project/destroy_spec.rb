require 'spec_helper'

describe ProjectDestroy do
  let(:project) { create :project }
  let(:user)    { project.owner }
  let(:action) do
    ProjectDestroy.run({
      current_user: user,
      project: {
        id: project.id.to_s
      }
    })
  end

  it { expect(action.success?).to eql true }
  it { expect(action.result).to eql nil }
end
