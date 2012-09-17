class Institution
  include MongoMapper::Document

  key :name, String
  key :location, String
  key :owner, ObjectId
  
  timestamps!
  userstamps!

  many :users
end

class School < Institution
end

class Organization < Institution
end
