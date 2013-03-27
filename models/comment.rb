class Comment
  include MongoMapper::Document

  key :body, String

  timestamps!

  belongs_to :user
  belongs_to :commentable, :polymorphic => true
end
