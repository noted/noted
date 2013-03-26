require 'spec_helper'

describe Tag do
  let(:tag)  { create(:tag) }
  let(:note) { create(:note) }

  before do
    note.tags << tag
    note.save
  end

  it { tag.should be_valid }
  it { tag.taggable.should eql note }
  it { note.tags.should include tag }
end
