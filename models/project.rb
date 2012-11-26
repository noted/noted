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

  before_validation :permalink!

  private

  def permalink!
    self.permalink = self.title.parameterize
  end
end