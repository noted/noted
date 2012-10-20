require "spec_helper"

describe Note do
	let(:user) { create(:user) }
  let(:note) { create(:note) }

  it "can be instantiated" do
    note.should_not be_nil
  end
end
