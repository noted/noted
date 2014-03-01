require 'spec_helper'

describe ProjectAddCollaborator do
  let(:project) { create :project }
  let(:owner)   { project.owner }
  let(:collaborator) { create :user }

  let(:action) do
    ProjectAddCollaborator.run({
      current_user: owner,
      project: project,
      user: {
        id: collaborator.id.to_s
      }
    })
  end

  it 'runs without errors' do
    expect(action.success?).to eql true
  end

  it 'returns a Project with the collaborator added' do
    expect(action.result.users).to include collaborator
  end

  it 'adds the project to the collaborators projects' do
    expect(action.result.users.last.projects).to include action.result
  end
end
