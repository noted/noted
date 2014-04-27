require 'spec_helper'

describe NoteSearch do
  let(:note)    { create :note }
  let(:project) { note.project }
  let(:user)    { project.owner }
  let(:action) do
    NoteSearch.run({
      current_user: user,
      project: project,
      query: 'Alpha'
    })
  end

  it 'should return accurate results' do
    expect(action.result).to include note
  end
end
