require "spec_helper"

describe Source do
	let(:user) { create(:user) }
  let(:source) { create(:source) }

  it "can be instantiated" do
    source.should_not be_nil
  end
end
