class User
  class Update < Mutations::Command
    required do
      model :id, class: BSON::ObjectId
    end

    optional do
      hash :user do
        string :username
        string :email
        string :name
        string :location
        string :website
      end
    end

    def execute
      u = User.find(id)

      u.update_attributes(user)

      u
    end
  end
end
