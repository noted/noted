require "spec_helper"

describe Project do
	let(:user) { create(:user) }
  let(:project) { create(:project) }

  it "can be instantiated" do
    project.should_not be_nil
  end
end
