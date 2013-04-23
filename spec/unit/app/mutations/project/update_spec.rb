require 'spec_helper'

describe Project::Update do
  let(:project) { create(:project) }
  let(:user)    { project.user }

  let(:action) do
    Project::Update.run({
      :author => user.id.to_s,
      :project => {
        :id => project.id.to_s,
        :title => 'Hayden Planetarium',
        :description => 'Foobar.'
      }
    })
  end

  before do
    project.reload
  end

  it { action.success?.should be_true }
  it { action.result.should be_an_instance_of Project }
  it { action.result.title.should eql 'Hayden Planetarium' }
  it { action.result.description.markdown.should eql 'Foobar.' }
  it { action.result.updater.should eql user }
end
