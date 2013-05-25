require 'spec_helper'

describe Scholar::Utilities::Contributor do
  context "author" do
    let(:c) { build(:contributor, :last) }

    it { c.should be_an_instance_of Scholar::Utilities::Contributor }
    it { c.name.should eql "Grossman, L. R., Esq" }
  end

  context "non-author" do
    let(:c) { build(:contributor, :first) }

    it { c.should be_an_instance_of Scholar::Utilities::Contributor }
    it { c.name.should eql "John Q. Sample, PhD"}
  end

  describe "#reorder!" do
    let(:first) { build(:contributor, :first) }
    let(:last)  { build(:contributor, :last) }

    before do
      first.reorder!(:last)
      last.reorder!(:first)
    end

    it { first.name.should eql "Sample, John Q., PhD" }
    it { last.name.should eql "L. R. Grossman, Esq" }
  end
end
