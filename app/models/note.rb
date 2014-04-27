class Note
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Userstamps
  include Mongoid::History::Trackable
  include Mongoid::TagsArentHard
  include PublicActivity::Model
  include Mongoid::Search

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

  taggable_with :tags, separator: ','

  # elasticsearch!

  search_in :title, :text

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

  def self.tags_for(project)
    self.where(project_id: project.id).all_tags
  end

  def tags_string(link = false)
    self.tags.join(',')
  end

  def updated_at_formatted
    self.updated_at.strftime('%e %B %Y, %l:%M%P')
  end

  def all_modifiers
    ids = self.history_tracks.collect { |t| t.modifier_id }.uniq
    ids.collect { |id| User.find(id) }
  end
end
