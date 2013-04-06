class Note
  include MongoMapper::Document

  key :title, String
  key :body, String
  key :permalink, String

  timestamps!
  userstamps!

  belongs_to :project

  many :sources

  many :comments, :as => :commentable
  many :tags, :as => :taggable

  after_create :permalink!

  def url
    "#{self.project.url}/notes/#{self.permalink}"
  end

  def html
    Maruku.new(self.body).to_html
  end

  def sources=(arr) # Array of IDs
    self.sources.clear

    arr.each do |id|
      sources << Source.find(id)
    end

    self.sources
  end

  def tags=(str)
    self.tags.each {|t| t.destroy }
    self.tags.clear

    arr = str.split(",")
    arr.each do |t|
      self.tags << Tag.new(:text => t)
    end

    self.tags
  end

  def tags_str
    arr = []
    tags.each {|t| arr << t.text }

    arr.compact.join(",").squish
  end

  private

  def permalink!
    self.permalink = Base32::Crockford.encode(Von.increment('notes'))
  end
end
