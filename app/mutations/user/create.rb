class User
  class Create < Mutations::Command
    required do
      hash :user do
        required do
          string :username
          string :email
          string :name
        end
      end

      hash :password do
        string :password
        string :confirm
      end
    end

    optional do
      string :institution
    end

    def execute
      u = User.new(user)

      if password[:password] == password[:confirm]
        u.password = password[:password]
      else
        add_error(:password, :doesnt_match, "Your passwords don't match")
      end

      unless user[:institution].blank?
        i = Institution.where(:code => institution).first
        i.users << u
      end

      u.save

      u
    end
  end
end
