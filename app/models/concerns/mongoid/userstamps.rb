module Mongoid
  module Userstamps
    extend ActiveSupport::Concern

    included do
      field :created_by, type: BSON::ObjectId
      field :updated_by, type: BSON::ObjectId
    end

    def creator
      User.find(self.created_by)
    end

    def creator=(u)
      self.created_by = u.id
    end

    def updater
      User.find(self.updated_by)
    end

    def updater=(u)
      self.updated_by = u.id
    end
  end
end
