require 'spec_helper'

describe Scholar::Utilities::Formatters do
  let(:s) { Scholar::Utilities }

  describe ".capitalize" do
    let(:str) { s.capitalize("foo") }

    it { str.should eql "Foo" }
  end

  describe ".carets" do
    let(:str) { s.carets("foo") }

    it { str.should eql "&#60;foo&#62;" }
  end

  describe ".colon" do
    let(:str) { s.colon("foo") }

    it { str.should eql "foo:" }
  end

  describe ".comma" do
    let(:str) { s.comma("foo") }

    it { str.should eql "foo," }
  end

  describe ".italicize" do
    let(:str) { s.italicize("foo") }

    it { str.should eql "<em>foo</em>" }
  end

  describe ".ordinal" do
    let(:int) { s.ordinal(1) }

    it { int.should eql "1st" }
  end

  describe ".period" do
    let(:str) { s.period("foo") }

    it { str.should eql "foo." }
  end

  describe ".quotes" do
    let(:str) { s.quotes("foo") }

    it { str.should eql "&#8220;foo&#8221;" }
  end

  describe ".replace" do
    let(:str) { s.replace("foo") }

    it { str.should eql "foo" }
  end

  describe ".underline" do
    let(:str) { s.underline("foo") }

    it { str.should eql "<u>foo</u>" }
  end
end
