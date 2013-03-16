class UserUpdate < Mutations::Command
  required do
    model :id, class: BSON::ObjectId
  end

  optional do
    string :username
    string :email
    string :name
    string :location
    string :website
  end

  def execute
    u = User.find(self.inputs[:id])
    u.update_attributes(self.inputs)

    u
  end
end
