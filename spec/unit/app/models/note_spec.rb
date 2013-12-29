require 'spec_helper'

describe Note do
  let(:note) { create :note }

  it { expect(note).to be_valid }

  it { expect(note).to validate_presence_of :title }
end
