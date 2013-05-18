class Password
  class Recover < Mutations::Command
    required do
      hash :user do
        string :id
      end

      hash :password do
        string :password
        string :confirm
      end
    end

    def execute
      u = User.find(user[:id])

      if password[:password] == password[:confirm]
        u.password = password[:password]
        u.secrets!
        u.save

        return u
      end
    end
  end
end
