# A command to create a new User.
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

      if self.institution_present?
        i = Institution.where(:code => self.institution).first
        i.users << u
      end

      u.save

      return u
    end
  end
end
