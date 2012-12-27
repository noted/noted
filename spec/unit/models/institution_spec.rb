require "spec_helper"

describe Institution do
  let(:institution) { create(:institution) }

  it { institution.should be_valid }

  describe "#code!" do
    it { institution.code.should == Base32::Crockford.encode(Institution.count + 1) }
  end
end
