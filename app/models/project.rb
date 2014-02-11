class Project
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title,     type: String
  field :summary,   type: String
  field :permalink, type: String
  field :owner_id,  type: BSON::ObjectId

  # TO-DO: validate presence of permalink, and uniqueness in context of
  #   the rest of the user's project's permalinks
  validates_presence_of :title

  has_and_belongs_to_many :users

  has_many :notes
  has_many :sources

  before_create :permalink!

  def viewable_by?(u)
    true
  end

  def updatable_by?(u)
    self.owner == u
  end

  def destroyable_by?(u)
    self.owner == u
  end

  def path(additions = nil)
    "/#{self.owner.username}/#{self.permalink}#{additions}"
  end

  def owner
    User.find(self.owner_id)
  end

  def owner=(u)
    self.owner_id = u.id
  end

  private

  def permalink!
    if permalink.blank?
      self.permalink = self.title.parameterize
    end
  end
end
