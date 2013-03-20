class User
  class Destroy < Mutations::Command
    required do
      model :user, class: BSON::ObjectId
    end

    def execute
      User.find(user).destroy
    end
  end
end
