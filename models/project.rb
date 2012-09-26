class Project
  include MongoMapper::Document

  key :title, String
  key :description, String
  key :private, Boolean, :default => false
  key :permalink, String
  key :collaborators, Array
  
  timestamps!
  userstamps!

  belongs_to :user

  many :sources
  many :notes
  one :paper

  def viewable_by?(u)
    if !private
      true
    else
      self.collaborators.each do |c|
        c == u
      end
    end
  end

  def updateable_by?(u)
    result = false

    self.collaborators.each do |c|
      if c == u
        result = true
      end
    end

    result
  end

  def destroyable_by?(u)
    self.creator == u
  end

end
