class Paper
  include MongoMapper::Document

  key :title, String
  key :text, String
  
  timestamps!
  userstamps!

  belongs_to :project

  many :comments, :as => :commentable

  def updateable_by?(u)
    result = false

    self.project.collaborators.each do |c|
      if c == u
        result = true
      end
    end

    result
  end
end
