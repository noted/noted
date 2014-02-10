require 'spec_helper'

describe ProjectCreate do
  let(:user) { create :user }
  let(:action) do
    ProjectCreate.run({
      current_user: user,
      project: {
        title: 'The Cosmos',
        summary: nil
      }
    })
  end

  it 'runs without errors' do
    expect(action.success?).to eql true
  end

  it 'returns a Project with correct attributes' do
    expect(action.result).to be_an_instance_of Project
    expect(action.result.user).to eql user
    expect(action.result.title).to eql 'The Cosmos'
  end
end
