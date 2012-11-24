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

  describe "#upgrade!" do
    before do
      user.upgrade!
    end

    it "should upgrade the User" do
      user.tier.should == "upgraded"
    end
  end

  describe "#downgrade!" do
    before do
      user.upgrade!
      user.downgrade!
    end

    it "should downgrade the User" do
      user.tier.should == "free"
    end
  end

  describe "#hire!" do
    before do
      user.hire!
    end

    it "should change the User into a staff member" do
      user.role.should == "staff"
    end
  end

  describe "#fire!" do
    before do
      user.hire!
      user.fire!
    end

    it "should change the User into a regular user" do
      user.role.should == "user"
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

  describe "validations" do
    describe "requirements" do
      it "should prevent lack of information" do
        u = User.new
        u.save.should_not be_true
      end
    end

    describe "uniqueness" do
      it "should prevent the same email" do
        u = User.new(:email => user.email, :name => "Foobar", :username => "foobar")
        u.save.should_not be_true
      end

      it "should prevent the same username" do
        u = User.new(:username => user.username, :name => "Foobar", :email => "foo@bar.com")
      end
    end
  end
end
