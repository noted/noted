class Project
  include MongoMapper::Document

  key :title, String
  key :description, String
  key :collaborators, Array
  key :permalink, String

  timestamps!
  userstamps!

  belongs_to :user

  many :notes
  many :sources

  validates_presence_of :title, :permalink

  before_validation :permalink!

  def add_collaborator(user)
    self.collaborators << user
  end

  def url
    "/#{self.user.username}/#{self.permalink}"
  end

  private

  def permalink!
    self.permalink = self.title.parameterize
  end
end