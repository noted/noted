require 'spec_helper'

describe Scholar::Utilities::Data do
  let(:s) { Scholar::Utilities }

  describe "#concatenate!" do
    let(:hash) do
      { :foo => "bar ", :bar => "foo", :foobar => "barfoo" }
    end

    let(:c) { s.concatenate!(hash) }

    it { c.should eql "bar foo barfoo" }
  end

  describe "#contributors!" do # Clean this up.
    let(:pre) do
      {
        :foo => "bar",
        :contributors => [
          {
            :role => :author,
            :first => "John",
            :last => "Green"
          },
          {
            :role => :author,
            :first => "Carl",
            :last => "Sagan"
          },
          {
            :role => :editor,
            :first => "Neil",
            :middle => "deGrasse",
            :last => "Tyson",
            :suffix => "PhD"
          },
          {
            :role => :translator,
            :first => "Dalai",
            :last => "Lama"
          }
        ]
      }
    end

    let(:post) do
      {
        :foo => "bar",
        :authors => "Green, John, Carl Sagan",
        :editors => "Neil D. Tyson, PhD",
        :translators => "Dalai Lama"
      }
    end

    let(:c) { s.contributors!(pre) }

    it { c.should eql post }
  end

  describe "#format!" do
    let(:hash) do
      { :foo => "Barfoo", :bar => "Foobar" }
    end

    let(:rules) do
      Scholar::Source.rules do
        rule(:foo) {|v| italicize(v) }
        rule(:bar) {|v| underline(v) }
      end
    end

    let(:result) do
      { :foo => "<em>Barfoo</em>", :bar => "<u>Foobar</u>" }
    end

    let(:c) { s.format!(hash, rules) }

    it { c.should eql result }
  end

  describe "#order!" do
    let(:hash) do
      { :foobar => "Foobar.", :bar => "Hello there.", :abc => "123" }
    end

    let(:sequence) do
      [ :abc, :foobar, :bar ]
    end

    let(:h) { s.order!(hash, sequence) }

    it { h.keys.should eql sequence }
  end
end
