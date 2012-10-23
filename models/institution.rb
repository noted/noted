class Institution
  include MongoMapper::Document

  key :name, String

  timestamps!
  userstamps!

  belongs_to :user
  many :users
end