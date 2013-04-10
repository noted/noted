class Source
  include MongoMapper::Document

  key :binary, Binary
  key :permalink, String

  timestamps!
  userstamps!

  belongs_to :project

  many :comments, :as => :commentable
  many :tags, :as => :taggable

  after_create :permalink!

  def citation=(obj)
    self.binary = Marshal::dump(obj)
  end

  def citation
    Marshal::load(self.binary.to_s)
  end

  def self.options
    [
      ["Book", "book"]
    ]
  end

  def url
    "#{self.project.url}/sources/#{self.permalink}"
  end

  private

  def permalink!
    self.permalink = Base32::Crockford.encode(Von.increment('sources'))
  end
end
