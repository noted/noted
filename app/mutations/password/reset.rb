class Password
  class Reset < Mutations::Command
    required do
      hash :user do
        string :id
      end
    end

    def execute
      u = User.find(user[:id])

      Noted::Web.deliver(:password, :reset, :user => u)
    end
  end
end
