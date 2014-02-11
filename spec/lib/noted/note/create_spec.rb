require 'spec_helper'

describe NoteCreate do
  let(:project) { create :project }
  let(:user)    { project.owner }
  let(:action) do
    NoteCreate.run({
      current_user: user,
      project: project,
      note: {
        title: 'Foobar',
        text: '**Foobar, _barfoo_.**'
      }
    })
  end

  it { expect(action.success?).to eql true }
  it { expect(action.result).to be_an_instance_of Note }
  it { expect(action.result.title).to eql 'Foobar' }
end
