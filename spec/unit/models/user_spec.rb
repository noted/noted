require "spec_helper"

describe User do
  let(:user) { create(:user) }

  it "can be instantiated" do
    user.should_not be_nil
  end

  describe "#authenticate" do
    before do
      @authenticated = User.authenticate(user.email, "foobar")
    end

    it "returns a User" do
      @authenticated.should be_an_instance_of User
    end

    it "can authenticate itself" do
      @authenticated.should == user
    end
  end

  describe "#password" do
    it "correctly matches a Password" do
      user.password.should == "foobar"
    end

    it "returns a Password object" do
      user.password.should be_an_instance_of BCrypt::Password
    end
  end

  describe "#password=" do
    before do
      user.password = "barfoo"
      user.save
    end

    it "changes the password" do
      user.password.should == "barfoo"
    end
  end

  describe "#destroy_projects!" do
    before do
      user.projects << Project.create(:title => "Foobar")

      user.destroy
    end

    it "should destroy all Projects associated with User" do
      Project.find(:title => "Foobar").should be_nil
    end
  end
end
