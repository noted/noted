class Institution
  include MongoMapper::Document
  include Canable::Ables

  key :name, String
  key :location, String
  key :owner, ObjectId
  
  timestamps!
  userstamps!

  many :users

  def updateable_by?(u)
  	owner == u
  end

  def destroyable_by?(u)
  	owner == u
  end
end

class School < Institution
end

class Organization < Institution
end
