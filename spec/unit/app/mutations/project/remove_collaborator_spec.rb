require 'spec_helper'

describe Project::AddCollaborator do
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

  it { project.success?.should be_true }
  it { project.result.should be_an_instance_of Project }
  it { project.result.collaborators.should_not include outsider }
end
