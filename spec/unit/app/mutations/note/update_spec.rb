require 'spec_helper'

describe Note::Update do
  let(:note) { create(:note) }
  let(:user) { note.project.user }

  let(:action) do
    Note::Update.run({
      :author => user.id.to_s,
      :note => {
        :id => note.id.to_s,
        :title => "Alpha Centauri",
        :body => "Foo to the bar to the foo."
      }
    })
  end

  before do
    note.reload
  end

  it { action.success?.should be_true }
  it { action.result.should be_an_instance_of Note }
  it { action.result.updater.should eql user }
  it { action.result.body.should eql "Foo to the bar to the foo." }
end
