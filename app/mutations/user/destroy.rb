class User
  class Destroy < Mutations::Command
    required do
      hash :user do
        required do
          string :id
        end
      end
    end

    def execute
      User.find(user[:id]).destroy
    end
  end
end
