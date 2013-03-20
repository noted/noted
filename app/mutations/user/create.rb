class User
  class Create < Mutations::Command
    required do
      string :username
      string :email
      string :name
      string :password
    end

    optional do
      string :institution
    end

    def execute
      u = User.create!(inputs)

      if institution_present?
        i = Institution.where(:code => institution).first
        i.users << u
      end

      u.save

      u
    end
  end
end
