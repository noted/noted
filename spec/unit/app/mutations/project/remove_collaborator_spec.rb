require 'spec_helper'

describe Project::RemoveCollaborator do
  let(:project)  { create(:project) }
  let(:user)     { project.user }
  let(:outsider) { create(:user) }

  let(:action) do
    Project::RemoveCollaborator.run({
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
  it { action.result.collaborators.should_not include outsider }
  it { User.find(action.inputs['collaborator']['id']).collaborations.should_not include project }
end
