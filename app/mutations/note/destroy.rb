class Note
  class Destroy < Mutations::Command
    required do
      string :author

      hash :note do
        string :id
      end
    end

    def execute
      n = Note.find(note[:id])
      n.updater = User.find(author)
      n.destroy
    end
  end
end
