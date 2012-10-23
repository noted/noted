class Note
  include MongoMapper::Document

  key :title, String
  key :body, String
  key :sources, Array

  timestamps!
  userstamps!

  belongs_to :project
end