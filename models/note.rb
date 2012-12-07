class Note
  include MongoMapper::Document

  key :title, String
  key :sources, Array
  key :permalink, String

  timestamps!
  userstamps!

  belongs_to :project

  many :sections

  after_create :permalink!
  after_save :preliminary

  private

  def permalink!
    self.permalink = Base32::Crockford.encode(self.class.count + 1)
  end

  def preliminary
    self.sections << Section.new
  end
end

class Section
  include MongoMapper::EmbeddedDocument

  key :title, String
  key :body, String

  embedded_in :note
end