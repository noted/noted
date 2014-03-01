require 'spec_helper'

describe ProjectRemoveCollaborator do
  let(:project) do
    p = create :project

    u2 = create :user

    p.users << u2
    p.save

    p
  end

  let(:owner)   { project.owner }
  let(:collaborator) { project.users.last }

  let(:action) do
    ProjectRemoveCollaborator.run({
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

  it 'returns a Project with the collaborator removed' do
    expect(action.result.users).to_not include collaborator
  end

  it 'removes the project to the collaborators projects' do
    expect(collaborator.projects).to_not include action.result
  end
end
