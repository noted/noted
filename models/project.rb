class Project
  include MongoMapper::Document

  key :title, String
  key :description, String
  key :permalink, String

  timestamps!
  userstamps!

  belongs_to :user

  many :notes
  many :sources

  validates_presence_of :title, :permalink

  before_validation :create_permalink!

  private

  def create_permalink!
    self.permalink = self.title.parameterize
  end

  # TO-DO: Check if the same permalink exists for a user.
end