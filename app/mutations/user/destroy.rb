class User
  class Destroy < Mutations::Command
    required do
      model :id, class: BSON::ObjectId
    end

    def execute
      User.find(id).destroy
    end
  end
end
