class Project
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title,     type: String
  field :summary,   type: String
  field :permalink, type: String

  validates_presence_of :title

  belongs_to :user

  has_many :notes
  has_many :sources

  before_create :permalink!

  def viewable_by?(u)
    true
  end

  def updatable_by?(u)
    self.user == u
  end

  def destroyable_by?(u)
    self.user == u
  end

  private

  def permalink!
    if permalink.blank?
      self.permalink = self.title.parameterize
    end
  end
end
