class Note
  class Destroy < Mutations::Command
    required do
      model :author, class: BSON::ObjectId

      hash :note do
        model :id, class: BSON::ObjectId
      end
    end

    def execute
      n = Note.find(note[:id])
      n.destroy
    end
  end
end
