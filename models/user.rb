require 'bcrypt'

class User
  include MongoMapper::Document
  include BCrypt

  key :name, String
  key :username, String
  key :email, String
  key :hash, String
  key :staff, Boolean, :default => false
  
  timestamps!

  belongs_to :instituton

  many :projects
  many :notes

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
end
