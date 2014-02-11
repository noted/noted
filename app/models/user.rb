class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Canable::Ables
  include Canable::Cans

  field :name,     type: String
  field :email,    type: String
  field :username, type: String

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

  validates_presence_of :name, :email, :username
  validates_uniqueness_of :email, :username

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
end
