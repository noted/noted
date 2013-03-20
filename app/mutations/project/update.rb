class Project
  class Update < Mutations::Command
    required do
      model :project, class: BSON::ObjectId
      model :author, class: BSON::ObjectId

      string :title
    end

    optional do
      string :description
    end

    def execute
      p = Project.find(project)
      p.update_attributes(
        :title => title,
        :description => description
      )

      p.updater = User.find(author)

      p.save

      p
    end
  end
end
