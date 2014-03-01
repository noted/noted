class Note
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Userstamps
  include Mongoid::History::Trackable

  field :title, type: String, default: 'Untitled'
  field :text,  type: String

  validates_presence_of :title

  belongs_to :project

  track_history on: [:title, :text],
                modifier_field: modifier,
                version_field: :version,
                track_create: true,
                track_update: true
                track_destroy: true

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
end
