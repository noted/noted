class Source
  include MongoMapper::Document
  
  timestamps!
  userstamps!

  belongs_to :project

  many :comments, :as => :commentable
end

class Book
end

class Website
end

# Completely incomplete.
