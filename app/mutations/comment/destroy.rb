class Comment
  class Destroy < Mutations::Command
    required do
      hash :comment do
        string :id
      end
    end

    def execute
      Comment.find(comment[:id]).destroy
    end
  end
end
