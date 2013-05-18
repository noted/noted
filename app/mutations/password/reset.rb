class Password
  class Reset < Mutations::Command
    required do
      string :email
    end

    def execute
      u = User.where(:email => email).first

      Noted::Web.deliver(:password, :reset, :user => u)
    end
  end
end
