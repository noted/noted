require "spec_helper"

describe Paper do
  let(:paper) { create(:paper) }
  
  it "can be instantiated" do
    paper.should_not be_nil
  end
end
