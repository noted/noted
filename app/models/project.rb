class Project
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Userstamps
  include Mongoid::History::Trackable
  include PublicActivity::Model

  field :title,             type: String
  field :summary,           type: String
  field :permalink,         type: String
  field :owner_id,          type: BSON::ObjectId
  field :citation_style_id, type: BSON::ObjectId

  validates :title, presence: true

  has_and_belongs_to_many :users

  has_many :notes
  has_many :sources

  before_validation :permalink!

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

  def citation_style
    CitationStyle.find(self.citation_style_id)
  end

  def citation_style=(c)
    self.citation_style_id = c.id
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
      p = self.title.parameterize

      similar = Project.where(
        owner_id: self.owner_id,
        permalink: /#{Regexp.quote(p)}/
      ).count

      if similar > 1
        p = "#{p}-#{similar + 1}"
      end

      self.permalink = p
    end
  end
end
