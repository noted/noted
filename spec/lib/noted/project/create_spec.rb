require 'spec_helper'

describe ProjectCreate do
  let(:owner) { create :user }
  let(:action) do
    ProjectCreate.run({
      current_user: owner,
      project: {
        title: 'The Cosmos',
        summary: nil,
        citation_style: nil
      }
    })
  end

  it 'runs without errors' do
    expect(action.success?).to eql true
  end

  it 'returns a Project with correct attributes' do
    expect(action.result).to be_an_instance_of Project
    expect(action.result.owner).to eql owner
    expect(action.result.title).to eql 'The Cosmos'
    expect(action.result.users).to include owner
  end
end
