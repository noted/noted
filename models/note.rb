class Note
  include MongoMapper::Document

  key :title, String
  key :sources, Array

  timestamps!
  userstamps!

  belongs_to :project

  many :boxes
end

class Box
  include MongoMapper::EmbeddedDocument

  key :title, String
  key :body, String

  embedded_in :note
end