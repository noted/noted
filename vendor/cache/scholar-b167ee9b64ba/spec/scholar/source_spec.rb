require 'spec_helper'

describe Scholar::Source do
  let(:s) { Scholar::Source }

  describe ".sequence" do
    context "passed Array" do
      let(:sequence) { s.sequence([:foo, :bar]) }

      it { s.sequence.should be_nil }
    end

    context "no arguments" do
      let(:sequence) { s.sequence }

      it { s.sequence.should be_nil }
    end
  end

  describe ".rules" do
    context "passed rule definitions" do
      let(:rules) { s.rules { rules(:foo) {|v| "#{v}"} } }

      it { s.sequence.should be_nil }
    end

    context "no arguments" do
      it { s.sequence.should be_nil }
    end
  end

  describe ".rule" do
    let(:rule) { s.rule(:foo) {|v| "#{v}"} }

    it { rule.pop[0].should eql(:foo) }
    it { rule.pop[1].should be_an_instance_of Proc }
  end
end
