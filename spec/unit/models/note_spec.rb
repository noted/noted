require "spec_helper"

describe Note do
	let(:user) { create(:user) }
  let(:note) { create(:note) }

  it "can be instantiated" do
    note.should be_valid
  end

  it "has embedded Boxes" do
    note.boxes.should_not be_nil
  end

  describe Box do
    let(:box) { create(:box) }

    it "can be initialized" do
      box.should be_valid
    end
  end
end
