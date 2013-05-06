class Note
  class Create < Mutations::Command
    required do
      string :project
      string :author
    end

    def execute
      p = Project.find(project)

      n = Note.new(
        :title => 'Untitled',
        :creator => User.find(author)
      )

      p.notes << n

      n.save

      n
    end
  end
end
