class User
  class Update < Mutations::Command
    required do
      model :user, class: BSON::ObjectId
    end

    optional do
      string :username
      string :email
      string :name
      string :location
      string :website
    end

    def execute
      u = User.find(user)

      u.update_attributes(inputs)

      u
    end
  end
end
