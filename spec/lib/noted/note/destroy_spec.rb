require 'spec_helper'

describe NoteDestroy do
  let(:note) { create :note }
  let(:user) { note.project.owner }
  let(:action) do
    NoteDestroy.run({
      current_user: user,
      note: {
        id: note.id.to_s
      }
    })
  end

  it { expect(action.success?).to eql true }
  it { expect(action.result).to eql nil }
end
