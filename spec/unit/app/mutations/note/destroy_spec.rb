require 'spec_helper'

describe Note::Update do
  let(:note) { create(:note) }
  let(:user) { note.project.user }

  let(:action) do
    Note::Destroy.run({
      :author => user.id,
      :note => {
        :id => note.id
      }
    })
  end

  it { action.success?.should be_true }
end
