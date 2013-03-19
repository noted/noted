class User
  class Destroy < Mutations::Command
    required do
      model :id, class: BSON::ObjectId
    end

    def execute
      User.find(inputs[:id]).destroy
    end
  end
end
