class Comment
  include MongoMapper::Document

  key :body, String

  timestamps!

  one :user
  belongs_to :commentable, :polymorphic => true
end
