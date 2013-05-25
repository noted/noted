require 'spec_helper'

describe Scholar::Utilities::ContributorList do
  context "authors" do
    let(:c) { build(:contributors, :author) }

    it { c.should be_an_instance_of Scholar::Utilities::ContributorList }
    it { c.names.should eql "Green, John, Douglas N. Adams, Neil D. Tyson, PhD"}
  end

  context "non-authors" do
    let(:c) { build(:contributors, :nonauthor) }

    it { c.should be_an_instance_of Scholar::Utilities::ContributorList }
    it { c.names.should eql "Carl Sagan, Neil D. Tyson, PhD"}
  end
end
