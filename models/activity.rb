class Activity
  include MongoMapper::Document

  key :actor_id, ObjectId

  key :recipient_class, String
  key :recipient_id, ObjectId

  key :action, String

  timestamps!

  validates_presence_of :actor_id, :recipient_class, :recipient_id, :action

  scope :by,  -> (a){ where(:actor_id => a) }
  scope :for, -> (r){ where(:recipient_id => r) }

  def actor
    User.find(actor_id)
  end

  def actor=(user)
    self.actor_id = user.id
  end

  def recipient
    self.recipient_class.constantize.find(recipient_id)
  end

  def recipient=(obj)
    self.recipient_class = obj.class.to_s
    self.recipient_id = obj.id
  end
end

