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
