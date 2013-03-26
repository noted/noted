class Comment
  class Create < Mutations::Command
    required do
      string :author

      hash :comment do
        string :body
        string :_type
        string :_id
      end
    end

    def execute
      c = Comment.new(:body => comment[:body])
      c.user = User.find(author)

      comment[:_type].constantize.find(comment[:_id]).comments << c

      c.save

      c
    end
  end
end
