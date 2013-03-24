class Project
  class Create < Mutations::Command
    required do
      model :user, class: BSON::ObjectId

      hash :project do
        required do
          string :title
        end

        optional do
          string :description
        end
      end
    end

    def execute
      u = User.find(user)

      p = Project.new(
        :title => project[:title],
        :description => project[:description],
        :creator => u
      )

      u.projects << p

      p.save

      p
    end
  end
end
