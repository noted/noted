class Note
  include MongoMapper::Document

  key :title, String
  key :sources, Array

  timestamps!
  userstamps!

  belongs_to :project

  many :sections

  after_save :preliminary

  private

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