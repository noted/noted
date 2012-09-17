class Comment
  include MongoMapper::Document

  key :text, String

  timestamps!
  userstamps!

  belongs_to :commentable, :polymorphic => true
end