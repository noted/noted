class Project
  include MongoMapper::Document

  key :title, String
  key :description, String
  key :permalink, String
  
  timestamps!
  userstamps!

  belongs_to :user

  many :sources
  many :notes
  one :paper
end
