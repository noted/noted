require 'maruku'

class Note
  include MongoMapper::Document

  key :title, String
  key :text, String
  key :html, String
  key :sources, Array
  
  timestamps!
  userstamps!

  belongs_to :user
  belongs_to :project

  before_save :html!

  private

  def html!
    self.html = Maruku.new(self.text).to_html
  end
end
