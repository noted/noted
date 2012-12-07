require "spec_helper"

describe Note do
	let(:user) { create(:user) }
  let(:note) { create(:note) }

  it "can be instantiated" do
    note.should be_valid
  end

  it "has embedded Sections" do
    note.sections.should_not be_blank
  end

  describe "#permalink!" do
    subject { note.permalink }

    it { should_not be_blank }
  end

  describe Section do
    let(:section) { create(:section) }

    it "can be initialized" do
      section.should be_valid
    end
  end
end
