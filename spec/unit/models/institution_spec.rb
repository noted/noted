require "spec_helper"

describe Institution do
  let(:institution) { create(:institution) }

  it "can be instantiated" do
    institution.should be_valid
  end
end
