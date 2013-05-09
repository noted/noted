require 'spec_helper'

describe Project::AddCollaborator do
  let(:project)  { create(:project) }
  let(:user)     { project.user }
  let(:outsider) { create(:user) }

  let(:action) do
    Project::AddCollaborator.run({
      :project => {
        :id => project.id.to_s
      },
      :collaborator => {
        :id => outsider.id.to_s
      }
    })
  end

  it { action.success?.should be_true }
  it { action.result.should be_an_instance_of Project }
  it { action.result.collaborators.should include outsider }
end
