require 'spec_helper'

describe CitationStyle do
  let(:style) { create :citation_style }

  it { expect(style).to be_valid }

  it { expect(style).to validate_presence_of :shortname }

  describe '#save_information!' do
    it { expect(style.title).to eql 'Modern Language Association 7th edition' }
  end
end
