class User
  class Update < Mutations::Command
    required do
      hash :user do
        string :id

        optional do
          string :username
          string :email
          string :name
          string :location, empty: true
          string :website, empty: true

          hash :password do
            string :password, empty: true
            string :confirm, empty: true
          end
        end
      end
    end

    def execute
      u = User.find(user[:id])

      u.update_attributes(user)

      if user[:password] && user[:password][:password] == user[:password][:confirm]
        u.password = user[:password][:password]
      end

      u.save

      u
    end
  end
end
