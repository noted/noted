require 'spec_helper'

describe Comment do
  let(:comment) { create(:comment) }
  let(:user)    { create(:user) }
  let(:note)    { create(:note) }

  before do
    note.comments << comment
    note.save

    comment.user = user
    comment.save
  end

  it { comment.should be_valid }
  it { comment.commentable.should eql note }
  it { comment.user.should eql user }
  it { note.comments.should include comment }
end
