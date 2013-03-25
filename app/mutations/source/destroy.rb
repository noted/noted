class Source
  class Destroy < Mutations::Command
    required do
      string :author

      hash :source do
        string :id
      end
    end

    def execute
      s = Source.find(source[:id])

      s.project.updater = User.find(author)

      s.destroy
    end
  end
end
