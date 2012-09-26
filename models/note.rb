require 'maruku'

class Note
  include MongoMapper::Document
  include Canable::Ables

  key :title, String
  key :text, String
  key :html, String
  key :sources, Array
  
  timestamps!
  userstamps!

  belongs_to :user
  belongs_to :project

  many :comments, :as => :commentable

  before_save :html!

  def creatable_by?(u)
    result = false

    self.project.collaborators.each do |c|
      if c == u
        result = true
      end
    end

    result
  end

  def updateable_by?(u)
    result = false

    self.project.collaborators.each do |c|
      if c == u
        result = true
      end
    end

    result
  end

  def destroyable_by?(u)
    self.project.creator == u
  end

  private

  def html!
    self.html = Maruku.new(self.text).to_html
  end
end
