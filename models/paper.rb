class Paper
  include MongoMapper::Document

  versioned
  
  key :title, String
  key :text, String
  
  timestamps!
  userstamps!


  belongs_to :project

  many :comments, :as => :commentable
end
