require 'bcrypt'

class User
  include MongoMapper::Document
  include BCrypt
  include Canable::Cans
  include Canable::Ables

  key :name, String
  key :username, String
  key :email, String
  key :hash, String

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
  
  timestamps!

  belongs_to :instituton

  many :projects
  many :institutions

  validates_presence_of :name, :username, :email
  validates_uniqueness_of :username, :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create

  before_destroy :clean!

  class << self
    def authenticate(e, p)
      u = first(:email => e) if e.present?
      u && u.password == p ? u : nil
    end
  end

  def clean!
    self.projects.each do |p|
      p.destroy
    end

    self.projects.empty?
  end

  def password
    @password ||= Password.new(hash)
  end

  def password=(new)
    self.hash = Password.create(new)
  end

  def updatable_by?(user)
    if self == user or user.role == "staff"
      true
    else
      false
    end
  end

  def destroyable_by?(user)
    updatable_by?(user)
  end
end
