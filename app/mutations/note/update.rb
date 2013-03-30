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
        end
      end
    end

    def execute
      n = Note.find(note[:id])

      n.update_attributes(
        :title => note[:title],
        :body => note[:body]
      )

      if note[:tags]
        n.tags.each do |t|
          t.destroy
          n.tags.clear
        end

        n.tags = create_tags(note[:tags])
      end

      n.updater = User.find(author)

      n.save

      n
    end

    def create_tags(str)
      raw = str.split(",")

      tags = []
      raw.each do |t|
        tags << Tag.new(:text => t)
      end

      tags
    end
  end
end
