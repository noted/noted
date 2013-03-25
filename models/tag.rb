class Tag
  include MongoMapper::Document

  key :text, String

  belongs_to :taggable, :polymorphic => true
end
