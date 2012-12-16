class Institution
  include MongoMapper::Document

  key :name, String
  key :code, String

  timestamps!
  userstamps!

  belongs_to :user
  
  many :users

  after_create :create_code!

  private

  def create_code!
    self.code = Base32::Crockford.encode(self.class.count + 1)
  end
end