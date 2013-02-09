require 'bcrypt'
require 'digest/md5'

class User
  include MongoMapper::Document
  include BCrypt
  include Canable::Ables
  include Canable::Cans

  key :name, String
  key :username, String
  key :email, String
  key :location, String
  key :hash, String
  
  timestamps!

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

  belongs_to :instituton

  many :projects
  many :institutions

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
  validates_presence_of :name, :username, :email
  validates_uniqueness_of :username, :email

  before_destroy :clean!

  def self.authenticate(e, p)
    u = first(:email => e) if e.present?
    u && u.password == p ? u : nil
  end

  def gravatar
    str = self.email.strip
    str = str.downcase
    str = Digest::MD5.hexdigest(str)

    "http://www.gravatar.com/avatar/#{str}?s=200"
  end

  def password
    @password ||= Password.new(hash)
  end

  def password=(str)
    self.hash = Password.create(str)
  end

  def updatable_by?(user)
    self == user || user.role == "staff"
  end

  def destroyable_by?(user)
    updatable_by?(user)
  end

  private

  def clean!
    self.projects.clear
    self.projects.empty?
  end
end
