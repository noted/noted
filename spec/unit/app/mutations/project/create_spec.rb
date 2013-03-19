require 'spec_helper'

describe Project::Create do
  let(:user)    { create(:user) }

  let(:project) do
    Project::Create.run({
      :user => user.id,

      :title => "The Cosmos",
      :description => "Foo to the bar to the foo."
    })
  end

  it { project.success?.should be_true }
  it { project.result.should be_an_instance_of Project }
end
