class Project
  include MongoMapper::Document

  key :title, String
  key :description, Markdown
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

  scope :given, -> (u, p){ where(:user_id => u, :permalink => p) }

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
