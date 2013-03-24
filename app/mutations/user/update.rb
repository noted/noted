class User
  class Update < Mutations::Command
    required do
      hash :user do
        required do
          string :id
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
