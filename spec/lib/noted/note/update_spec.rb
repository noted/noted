require 'spec_helper'

describe NoteUpdate do
  let(:note)    { create :note }
  let(:user)    { note.project.owner }
  let(:action) do
    NoteUpdate.run({
      current_user: user,
      note: {
        id: note.id.to_s,
        title: 'Foobar',
        text: '**Foobar, _barfoo_.**'
      }
    })
  end

  it { expect(action.success?).to eql true }
  it { expect(action.result).to be_an_instance_of Note }
  it { expect(action.result.title).to eql 'Foobar' }
  it { expect(action.result.text).to eql '**Foobar, _barfoo_.**' }
  it { expect(action.result.updater).to eql user }
end
