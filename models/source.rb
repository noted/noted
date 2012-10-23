class Source
  include MongoMapper::Document

  key :attributes, Hash

  timestamps!
  userstamps!

  belongs_to :project
end