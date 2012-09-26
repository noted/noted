require 'bcrypt'

class User
  include MongoMapper::Document
  include BCrypt
  include Canable::Ables

  key :name, String
  key :username, String
  key :email, String
  key :location, String
  key :hash, String

  timestamps!

  belongs_to :instituton

  many :projects
  many :notes

  def updateable_by?(u)
    self == u
  end

  def destroyable_by?(u)
    self == u
  end

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

class Student < User
end

class Instructor < User
end

class Researcher < User
end
