class Paper
  include MongoMapper::Document

  key :title, String
  key :body, String
  
  timestamps!
  userstamps!

  belongs_to :project
end
