class Note
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Userstamps
  include Mongoid::History::Trackable
  include Mongoid::TaggableWithContext
  include Mongoid::TaggableWithContext::AggregationStrategy::RealTime
  include PublicActivity::Model

  field :title, type: String, default: 'Untitled'
  field :text,  type: String

  validates :title, presence: true

  belongs_to :project

  tracked

  track_history on: [:title, :text],
                modifier_field: :updater,
                version_field: :version,
                track_create: true,
                track_update: true,
                track_destroy: true

  taggable :tags, separator: ','

  def creatable_by?(u)
    self.project.users.include?(u)
  end

  def viewable_by?(u)
    true
  end

  def updatable_by?(u)
    self.creatable_by?(u)
  end

  def destroyable_by?(u)
    self.creatable_by?(u)
  end

  def authors
    self.history_tracks.collect { |t| t.modifier }.uniq
  end

  def path
    self.project.path("/notes/#{self.id}")
  end
end
