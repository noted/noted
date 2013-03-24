class Project
  class Update < Mutations::Command
    required do
      model :author, class: BSON::ObjectId

      hash :project do
        required do
          model :id, class: BSON::ObjectId
          string :title
        end

        optional do
          string :description
        end
      end
    end

    def execute
      p = Project.find(project[:id])

      p.update_attributes(
        :title => project[:title],
        :description => project[:description],

        :updater => User.find(author)
      )

      p.save

      p
    end
  end
end
