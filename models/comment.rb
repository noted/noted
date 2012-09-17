class Comment
  include MongoMapper::EmbeddedDocument

  plugin MongoMapper::Plugins::Timestamps
  plugin MongoMapper::Plugins::Userstamps

  key :text, String

  timestamps!
  userstamps!

  belongs_to :commentable, :polymorphic => true
end