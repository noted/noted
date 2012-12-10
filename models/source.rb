class Source
  include MongoMapper::Document

  key :attributes, Hash
  key :markdown, String
  key :html, String

  timestamps!
  userstamps!

  belongs_to :project

  after_save :format!

  private

  def format!
  end
end