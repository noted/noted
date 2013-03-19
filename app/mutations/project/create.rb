class Project
  class Create < Mutations::Command
    required do
      model :user, class: BSON::ObjectId

      string :title
    end

    optional do
      string :description
    end

    def execute
      u = User.find(user)

      p = Project.new(
        :title => title,
        :description => description,
        :creator => u
      )

      u.projects << p

      p.save

      p
    end
  end
end
