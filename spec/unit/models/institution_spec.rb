require "spec_helper"

describe Institution do
  let(:institution) { create(:institution) }

  it "can be instantiated" do
    institution.should be_valid
  end

  describe "#create_code!" do
    subject { institution.code }

    it { should_not be_blank }
    it { should == Base32::Crockford.encode(Institution.count + 1) }
  end
end
