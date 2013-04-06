class Note
  class Update < Mutations::Command
    required do
      string :author

      hash :note do
        required do
          string :id
          string :title
        end

        optional do
          string :body
          string :tags
          array :sources
        end
      end
    end

    def execute
      n = Note.find(note[:id])

      n.update_attributes(note)
      n.updater = User.find(author)

      n.save

      n
    end
  end
end
