require "spec_helper"

describe User do
  let(:user)  { create(:user) }
  let(:staff) { create(:staff) }

  it "can be instantiated" do
    user.should be_valid
  end

  describe "#authenticate" do
    subject { User.authenticate(user.email, "foobar") }

    it { should be_an_instance_of User }
    it { should == user }
  end

  describe "#password" do
    subject { user.password }

    it { should be_an_instance_of BCrypt::Password }
    it { should == "foobar" }
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

  describe "#clean!" do
    before do
      user.projects << Project.create(:title => "Foobar")

      user.destroy
    end

    it "should destroy all Projects associated with User" do
      Project.find(:title => "Foobar").should be_nil
    end
  end

  describe "#updatable_by?" do
    it "should allow a staff member to update a User" do
      user.updatable_by?(staff).should be_true
    end

    it "should not allow a User to update a staff member" do
      staff.updatable_by?(user).should be_false
    end

    it "should allow a User to update itself" do
      user.updatable_by?(user).should be_true
    end
  end

  describe "#destroyable_by?" do
    it "should allow a staff member to destroy a User" do
      user.destroyable_by?(staff).should be_true
    end

    it "should not allow a User to destroy a staff member" do
      staff.destroyable_by?(user).should be_false
    end

    it "should allow a User to destroy itself" do
      user.destroyable_by?(user).should be_true
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

    describe "format" do
      it "should prevent input of an invalid email" do
        u = User.new(:email => "foobar", :name => "Foobar", :username => "foobar")
        u.save.should_not be_true
      end
    end
  end
end
