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

  def collaborators(links = false)
    if links
      self.users.collect { |u| "<a href='/#{u.username}'>#{u.name}</a>" }.join(', ').html_safe
    else
      self.users.collect { |u| u.name }.join(', ')
    end
  end

  def self.style_options(current_project = nil)
    values = [
      ['modern-language-assocation', 'Modern Language Association'],
      ['apa', 'American Psychological Association']
    ]

    html = ''
    values.each do |value|
      if current_project && current_project.citation_style == value[0]
        html << "<option value='#{value[0]}' selected='selected'>#{value[1]}</option>"
      else
        html << "<option value='#{value[0]}'>#{value[1]}</option>"
      end
    end

    html.html_safe
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
