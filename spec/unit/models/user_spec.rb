require "spec_helper"

describe User do
  let(:user) { create(:user) }

  it "can be instantiated" do
    user.should_not be_nil
  end

  it "can correctly match a Password" do
    user.password.should == "foobar"
  end

  it "returns a Password object" do
    user.password.should be_an_instance_of BCrypt::Password
  end

  it "can authenticate itself" do
    User.authenticate(user.email, "foobar").should == user
  end
end
