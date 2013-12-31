require 'spec_helper'

describe Source do
  let(:source) { create :source }

  it { expect(source).to be_valid }

  describe '#citation!' do
    let(:citation) do
      'Poe, Edgar Allen. <i>Poetry, Tales, and Selected Essays</i>. Ed. Patrick F. Quinn and G.R. Thompson. New York: Library of America, 1996. Print.'
    end

    it { expect(source.citation).to eql citation }
  end
end
