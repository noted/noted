class Activity
  include MongoMapper::Document

  key :actor_id, ObjectId

  key :recipient_class, String
  key :recipient_id, ObjectId

  key :action, String

  timestamps!

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
