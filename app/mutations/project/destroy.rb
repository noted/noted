class Project
  class Destroy < Mutations::Command
    required do
      hash :project do
        string :id
      end
    end

    def execute
      p = Project.find(project[:id])

      p.notes.each   { |n| n.destroy }
      p.sources.each { |s| s.destroy }

      p.destroy
    end
  end
end
