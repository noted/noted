require "spec_helper"

describe Institution do
  let(:institution) { create(:institution) }
  
  it "can be instantiated" do
    institution.should_not be_nil
  end
end
