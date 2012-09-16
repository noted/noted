class Paper
  include MongoMapper::Document

  key :title, String
  key :text, String
  
  timestamps!
  userstamps!

  belongs_to :project
end
