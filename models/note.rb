class Note
  include MongoMapper::Document

  key :title, String
  key :body, String
  key :sources, Array
  key :permalink, String

  timestamps!
  userstamps!

  validates_uniqueness_of :permalink

  belongs_to :project

  many :comments, :as => :commentable
  many :tags, :as => :taggable

  after_create :permalink!

  def url
    "#{self.project.url}/notes/#{self.permalink}"
  end

  def html
    Maruku.new(self.body).to_html
  end

  def tags_str
    arr = []
    tags.each {|t| arr << t.text }

    arr.compact.join(",").squish
  end

  private

  def permalink!
    self.permalink = Base32::Crockford.encode(self.class.count + 1)
  end
end
