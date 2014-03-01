require 'spec_helper'

describe ProjectUpdate do
  let(:project) { create :project }
  let(:user)    { project.owner }

  let(:action) do
    ProjectUpdate.run({
      current_user: user,
      project: {
        id: project.id.to_s,
        title: 'Our Universe',
        summary: '',
        citation_style: project.citation_style
      }
    })
  end

  it 'runs without errors' do
    expect(action.success?).to eql true
  end

  it 'returns a Project with correct attributes' do
    expect(action.result).to be_an_instance_of Project
    expect(action.result.title).to eql 'Our Universe'
    expect(action.result.updater).to eql user
  end
end
