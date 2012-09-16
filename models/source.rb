class Source
  include MongoMapper::Document
  
  timestamps!
  userstamps!

  belongs_to :project
end

class Book
end

class Website
end

# Completely incomplete.
