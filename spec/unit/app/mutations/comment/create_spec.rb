require 'spec_helper'

describe Comment::Create do
  let(:user) { create(:user) }
  let(:note) { create(:note) }

  let(:comment) do
    Comment::Create.run({
      :author => user.id.to_s,
      :comment => {
        :body => "Foo to the bar to the foo.",
        :_id => note.id.to_s,
        :_type => "Note"
      }
    })
  end

  it { comment.success?.should be_true }
  it { comment.result.should be_an_instance_of Comment }
  it { comment.result.commentable.should eql note }
  it { comment.result.user.should eql user }
end
