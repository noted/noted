class User
  class Create < Mutations::Command
    required do
      hash :user do
        required do
          string :username
          string :email
          string :name
          string :password
        end

        optional do
          string :institution
        end
      end
    end

    def execute
      u = User.create!(user)

      unless user[:institution].blank?
        i = Institution.where(:code => institution).first
        i.users << u
      end

      u.save

      u
    end
  end
end
