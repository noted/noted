require 'spec_helper'

describe User::Create do
  let(:user) do
    User::Create.run({
      :user => {
        :name => "Carl Sagan",
        :email => "carl@sagan.org",
        :username => "carl"
      },
      :password => {
          :password => "foobar",
          :confirm => "foobar"
      }
    })
  end

  it { user.success?.should be_true }
  it { user.result.should be_an_instance_of User }
end
