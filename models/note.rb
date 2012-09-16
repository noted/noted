require 'rdiscount'

class Note
  include MongoMapper::Document

  key :title, String
  key :body, String
  key :html, String
  key :sources, Array
  
  timestamps!
  userstamps!

  belongs_to :user
  belongs_to :project

  validates_presence_of :body, :html

  before_save :convert

  private

  def convert
    self.html = RDiscount.new(self.body).to_html
  end
end
