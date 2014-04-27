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
        text: '**Foobar, _barfoo_.**',
        tags: 'foo,bar'
      }
    })
  end

  it { expect(action.success?).to eql true }
  it { expect(action.result).to be_an_instance_of Note }
  it { expect(action.result.title).to eql 'Foobar' }
  it { expect(action.result.text).to eql '**Foobar, _barfoo_.**' }
  it { expect(action.result.updater).to eql user }
  it { expect(action.result.tags).to eql ['foo', 'bar'] }
  it { expect(action.result.updated_at.to_s).to eql action.result.project.updated_at.to_s }
end
