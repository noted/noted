class Project
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title,     type: String
  field :summary,   type: String
  field :permalink, type: String
  field :collaborator_ids, type: Array, default: []

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

  def path(additions = nil)
    "/#{self.user.username}/#{self.permalink}#{additions}"
  end

  def collaborators
    arr = []

    self.collaborator_ids.each do |id|
      arr << User.find(id)
    end

    arr
  end

  private

  def permalink!
    if permalink.blank?
      self.permalink = self.title.parameterize
    end
  end
end
