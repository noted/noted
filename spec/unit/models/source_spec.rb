require "spec_helper"

describe Source do
  let(:user)   { create(:user) }
  let(:source) { create(:source) }

  it "can be instantiated" do
    source.should be_valid
  end

  describe "#format!" do
  end
end
