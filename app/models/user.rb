require 'digest/md5'

class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Userstamps
  include Canable::Ables
  include Canable::Cans

  field :name,      type: String
  field :email,     type: String
  field :username,  type: String
  field :biography, type: String
  field :location,  type: String
  field :social,    type: Hash, default: { twitter: '' }
  field :admin,     type: Boolean, default: false

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # Database authenticatable
  field :encrypted_password, type: String, default: ''

  # Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  # Rememberable
  field :remember_created_at, type: Time

  # Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true

  has_and_belongs_to_many :projects

  def viewable_by?(u)
    true
  end

  def updatable_by?(u)
    self == u
  end

  def destroyable_by?(u)
    self == u
  end

  def gravatar
    "//gravatar.com/avatar/#{Digest::MD5.hexdigest(self.email)}?s=500"
  end

  def current_admin
    self.admin == true
  end
end
