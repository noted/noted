class Note
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :text,  type: String

  validates_presence_of :title

  belongs_to :project

  def creatable_by?(u)
    self.project.user == u
  end

  def viewable_by?(u)
    true
  end

  def updatable_by?(u)
    self.project.user == u
  end

  def destroyable_by?(u)
    self.project.user == u
  end
end
