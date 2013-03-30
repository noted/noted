require 'spec_helper'

describe Comment do
  let(:comment) { create(:comment) }
  let(:note)    { create(:note) }

  before do
    note.comments << comment
    note.save

    comment.save
  end

  it { comment.should be_valid }
  it { comment.commentable.should eql note }
  it { note.comments.should include comment }
end
