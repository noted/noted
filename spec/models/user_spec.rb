require "spec_helper"

describe User do
  let(:user) { User.new }

  it "can be instantiated" do
    user.should_not be_nil
  end
end
