class Comment
  class Create < Mutations::Command
    required do
      hash :comment do
        string :author
        string :body
        string :_type
        string :_id
      end
    end

    def execute
      c = Comment.new(:body => comment[:body])
      c.user = User.find(comment[:author])

      comment[:_type].constantize.find(comment[:_id]).comments << c

      c.save

      c
    end
  end
end
