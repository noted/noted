class Project
  include MongoMapper::Document

  plugin MongoMapper::Plugins::Paranoid

  key :title, String
  key :description, String
  key :collaborator_ids, Array
  key :permalink, String

  timestamps!
  userstamps!

  belongs_to :user

  many :notes
  many :sources

  many :comments, :as => :commentable

  validates_presence_of :title#, :permalink

  before_save :permalink!

  after_create :create_activity
  after_update :update_activity
  after_destroy :destroy_activity

  scope :given, -> (u, p){ where(:user_id => u, :permalink => p, :deleted_at => nil) }

  def create_activity
    Activity.create(
      :actor => self.creator,
      :recipient => self,
      :action => 'create'
    )
  end

  def update_activity
    Activity.create(
      :actor => self.updater,
      :recipient => self,
      :action => 'update'
    )
  end

  def destroy_activity
    Activity.create(
      :actor => self.creator,
      :recipient => self,
      :action => 'destroy'
    )
  end

  def authors
    result = "<a href='/#{self.creator.username}'>#{self.creator.name}</a>"

    self.collaborators.each do |c|
      result << ", <a href='#{c.username}'>#{c.name}</a>"
    end

    result
  end

  def collaborators
    arr = []

    collaborator_ids.each do |id|
      arr << User.find(id)
    end

    arr
  end

  def url
    "/#{self.user.username}/#{self.permalink}"
  end

  def updatable_by?(u)
    u == self.user || u.staff?
  end

  def destroyable_by?(u)
    updatable_by?(u)
  end

  private

  def permalink!
    self.permalink = self.title.parameterize
  end
end
