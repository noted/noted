class Project
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title,     type: String
  field :permalink, type: String

  validates_presence_of :title

  belongs_to :user

  has_many :notes

  before_create :permalink!

  private

  def permalink!
    if permalink.blank?
      self.permalink = self.title.parameterize
    end
  end
end
