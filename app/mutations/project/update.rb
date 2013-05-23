class Project
  class Update < Mutations::Command
    required do
      string :author

      hash :project do
        required do
          string :id
          string :title
        end

        optional do
          string :description, empty: true
          string :collaborators, empty: true
        end
      end
    end

    def execute
      p = Project.find(project[:id])

      p.update_attributes(
        :title => project[:title],
        :description => project[:description],
        :collaborators => project[:collaborators],
        :updater => User.find(author)
      )

      p.save

      p
    end
  end
end
