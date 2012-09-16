require 'bcrypt'

class User
  include MongoMapper::Document
  include BCrypt

  key :name, String
  key :username, String
  key :email, String
  key :location, String
  key :hash, String

  timestamps!

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
