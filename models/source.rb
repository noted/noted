class Source
  include MongoMapper::Document

  plugin MongoMapper::Plugins::Paranoid

  key :binary, Binary
  key :permalink, String

  timestamps!
  userstamps!

  belongs_to :project

  many :comments, :as => :commentable
  many :tags, :as => :taggable

  after_create :permalink!

  scope :within, -> (id){
    where(:project_id => id, :deleted_at => nil).
    order('updated_at dsc')
  }

  def citation=(obj)
    self.binary = Marshal::dump(obj)
  end

  def citation
    Marshal::load(self.binary.to_s)
  end

  def self.options # Bad.
    [
      ['Book', 'book']
    ]
  end

  def url
    "#{self.project.url}/sources/#{self.permalink}"
  end

  def creatable_by?(u)
    u == self.project.user || self.project.collaborator_ids.include?(u.id) || u.staff?
  end

  def updatable_by?(u)
    creatable_by?(u)
  end

  def destroyable_by?(u)
    creatable_by?(u)
  end

  private

  def permalink!
    self.permalink = Base32::Crockford.encode(Von.increment('sources'))
  end
end
