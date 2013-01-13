require "spec_helper"

describe User do
  let(:user)  { create(:user) }
  let(:staff) { create(:user, :staff) }

  it { should validate_presence_of :username }
  it { should validate_presence_of :name }
  it { should validate_presence_of :email }

  it { should validate_uniqueness_of :username }
  it { should validate_uniqueness_of :email }

  it { should_not allow_value("foobar").for(:email) }

  it { user.should be_valid }

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

    it { user.password.should == "barfoo" }
  end

  describe "#upgrade!" do
    before do
      user.upgrade!
    end

    it { user.tier.should == "upgraded" }
  end

  describe "#downgrade!" do
    before do
      user.upgrade!
      user.downgrade!
    end

    it { user.tier.should == "free" }
  end

  describe "#hire!" do
    before do
      user.hire!
    end

    it { user.role.should == "staff" }
  end

  describe "#fire!" do
    before do
      user.hire!
      user.fire!
    end

    it { user.role.should == "user" }
  end

  describe "#clean!" do
    before do
      user.projects << Project.create(:title => "Foobar")

      user.destroy
    end

    it { Project.find(:title => "Foobar").should be_nil }
  end

  describe "#updatable_by?" do
    it { user.updatable_by?(staff).should be_true }
    it { staff.updatable_by?(user).should be_false }
    it { user.updatable_by?(user).should be_true }
  end

  describe "#destroyable_by?" do
    it { user.destroyable_by?(staff).should be_true }
    it { staff.destroyable_by?(user).should be_false }
    it { user.destroyable_by?(user).should be_true }
  end
end
