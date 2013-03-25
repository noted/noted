require 'spec_helper'

describe Note::Create do
  let(:project) { create(:project) }
  let(:user)    { project.user }

  let(:note) do
    Note::Create.run({
      :project => project.id.to_s,
      :author => user.id.to_s,
    })
  end

  it { note.success?.should be_true }
  it { note.result.should be_an_instance_of Note }
  it { note.result.title.should eql "Untitled" }
end
