class Activity
  include MongoMapper::Document

  key :actor_id, ObjectId

  key :recipient_class, String
  key :recipient_id, ObjectId

  key :recipient_parent_class, String, :default => 'Project'
  key :recipient_parent_id, ObjectId

  key :action, String

  key :permalink, String

  timestamps!

  validates_presence_of :actor_id, :recipient_class, :recipient_id, :action

  before_create :permalink!
  after_create :segment!

  scope :by,  -> (a){ where(:actor_id => a) }
  scope :for, -> (r){ where(:recipient_id => r) }
  scope :within, -> (p) do
    where(:$or => [
      { :recipient_id => p },
      { :recipient_parent_id => p }
    ]).order('created_at dsc')
  end

  def actor
    User.find(actor_id)
  end

  def actor=(user)
    if user.is_a?(User)
      self.actor_id = user.id
    else
      self.actor_id = user
    end
  end

  def recipient
    self.recipient_class.constantize.find(recipient_id)
  end

  def recipient=(obj)
    self.recipient_class = obj.class.to_s
    self.recipient_id = obj.id
  end

  def recipient_parent
    self.recipient_parent_class.constantize.find(recipient_parent_id)
  end

  def recipient_parent=(obj)
    self.recipient_parent_id = obj.id
  end

  def sentence
    case action
    when 'create'
      verb = 'created'
    when 'update'
      verb = 'updated'
    when 'destroy'
      verb = 'destroyed'
    end

    case recipient_parent_class
    when 'Project'
      post = "#{recipient.title}"
    when 'Note'
      post = "#{recipient.title}"
    when 'Source'
      post = "a Source"
    end

    "#{actor.name} #{verb} #{post}."
  end

  private

  def permalink!
    self.permalink = Base32::Crockford.encode(Von.increment('activities'))
  end

  def segment!
    event = "#{self.action.capitalize} "

    if self.recipient.is_a?(Project) || self.recipient.is_a?(Note)
      event << self.recipient.title
    else
      event << "a #{self.recipient.citation.raw['type'].capitalize}"
    end

    Analytics.track(
      :user_id => self.actor.id.to_s,
      :event => event,
      :properties => self.recipient.serializable_hash
    )
  end
end
