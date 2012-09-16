class User
  include MongoMapper::Document

  timestamps!
end

class Student < User
end

class Instructor < User
end

class Researcher < User
end
