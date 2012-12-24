class Source
  include MongoMapper::Document

  key :attributes, Hash
  key :markdown, String
  key :html, String
  key :permalink, String

  timestamps!
  userstamps!

  belongs_to :project

  after_save :format!

  private

  def format!
  end

  def create_permalink!
  end
end