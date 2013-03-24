class Note
  class Update < Mutations::Command
    required do
      model :author, class: BSON::ObjectId

      hash :note do
        required do
          model :id, class: BSON::ObjectId
          string :title
        end

        optional do
          string :body
        end
      end
    end

    def execute
      n = Note.find(note[:id])

      n.update_attributes(
        :title => note[:title],
        :body => note[:body]
      )

      n.updater = User.find(author)

      n.save

      n
    end
  end
end
