require "spec_helper"

describe "Users" do
  describe "GET /:username" do
    before do
      @u = create(:user)

      get "/#{@u.username}"
    end

    it "should be ok" do
      response.should be_ok
    end
  end

	describe "GET /join" do
    before do
      get "/join"
    end

    it "should be ok" do
      response.should be_ok
    end
  end

  describe "POST /users/create" do
    before do
      post "/users/create", :user => { :name => "Carl Sagan", :email => "carl@astrophysics.org", :password => "foobar" }
    end

    it "should redirect correctly" do
      response.should be_redirect
      response.location.should == "#{site}/"
    end

    it "should create a User" do
      User.find_by_name("Carl Sagan").should_not be_nil
    end
  end

  describe "PUT /users/modify" do
    before do
      put "/users/modify", :id => @u.id, :user => { :name => "Sagan, Carl" }

      @u.reload
    end

    it "should redirect correctly" do
      response.should be_redirect
      response.location.should == "#{site}/settings/account"
    end

    it "should modify a User" do
      @u.name.should == "Sagan, Carl"
    end
  end

  describe "DELETE /users/destroy" do
    before do
      delete "/users/destroy", :id => @u.id
    end

    it "should redirect correctly" do
      response.should be_redirect
      response.location.should == "#{site}/"
    end

    it "should destroy a User" do
      User.find_by_name("Neil deGrasse Tyson").should be_nil
    end
  end
end