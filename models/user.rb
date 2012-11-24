require 'bcrypt'

class User
  include MongoMapper::Document
  include BCrypt

  key :name, String
  key :username, String
  key :email, String
  key :hash, String

  state_machine :tier, :initial => :free do
    state :free
    state :upgraded

    event :upgrade do
      transition all => :upgraded
    end

    event :downgrade do
      transition all => :free
    end
  end

  state_machine :role, :initial => :user do
    state :user
    state :staff

    event :hire do
      transition all => :staff
    end

    event :fire do
      transition all => :user
    end
  end
  
  timestamps!

  belongs_to :instituton

  many :projects
  many :institutions

  validates_presence_of :name, :username, :email
  validates_uniqueness_of :username, :email

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
