class Project
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Userstamps
  include Mongoid::History::Trackable
  include PublicActivity::Model

  field :title,          type: String
  field :summary,        type: String
  field :permalink,      type: String
  field :owner_id,       type: BSON::ObjectId
  field :citation_style, type: String, default: 'modern-language-association'

  # TO-DO: validate presence of permalink, and uniqueness in context of
  #   the rest of the user's project's permalinks
  validates_presence_of :title

  has_and_belongs_to_many :users

  has_many :notes
  has_many :sources

  before_create :permalink!

  tracked

  track_history on: [:title, :summary, :citation_style],
                modifier_field: :updater,
                version_field: :version,
                track_create: true,
                track_update: true,
                track_destroy: true

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

  def collaborators(links = false)
    if links
      self.users.collect { |u| "<a href='/#{u.username}'>#{u.name}</a>" }.join(', ').html_safe
    else
      self.users.collect { |u| u.name }.join(', ')
    end
  end

  private

  def permalink!
    if permalink.blank?
      self.permalink = self.title.parameterize
    end
  end
end
