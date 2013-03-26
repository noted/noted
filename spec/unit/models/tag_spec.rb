require 'spec_helper'

describe Tag do
  let(:tag) { create(:tag) }
  let(:note) do
    n = create(:note)
    n.tags << tag
    n
  end

  it { tag.should be_valid }
  it { note.tags.should include tag }
end
