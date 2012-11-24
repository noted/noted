require 'bcrypt'

class User
  include MongoMapper::Document
  include BCrypt

  key :name, String
  key :username, String
  key :email, String
  key :hash, String
  
  timestamps!

  belongs_to :instituton

  many :projects
  many :institutions

  validates_presence_of :name, :username, :email

  before_destroy :destroy_projects!

  class << self
    def authenticate(e, p)
      u = first(:email => e) if e.present?
      u && u.password == p ? u : nil
    end
  end

  def password
    @password ||= Password.new(hash)
  end

  def password=(new)
    self.hash = Password.create(new)
  end

  def destroy_projects!
    self.projects.each do |p|
      p.destroy
    end

    self.projects.empty?
  end
end
