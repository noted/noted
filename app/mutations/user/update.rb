class User
  class Update < Mutations::Command
    required do
      hash :user do
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
      end
    end

    def execute
      u = User.find(user[:id])

      u.update_attributes(user)

      u
    end
  end
end
