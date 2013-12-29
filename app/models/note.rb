class Note
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :text,  type: String

  validates_presence_of :title

  belongs_to :project
end
