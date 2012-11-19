class Institution
  include MongoMapper::Document

  key :name, String
  key :code, String

  timestamps!
  userstamps!

  belongs_to :user
  
  many :users
end