require 'spec_helper'

describe Comment::Destroy do
  let(:note) { create(:note) }

  let(:comment) do
    c = create(:comment)

    note.comments << c
    note.save

    c.save

    c
  end

  let(:action) do
    Comment::Destroy.run({
      :comment => {
        :id => comment.id.to_s
      }
    })
  end

  it { action.success?.should be_true }
end
