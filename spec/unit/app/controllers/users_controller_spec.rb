require 'spec_helper'

describe "Users" do
  let(:user) { create(:user) }

  describe "GET /join" do
    before do
      get "/join"
    end

    it "is ok" do
      response.should be_ok
    end
  end

  describe "POST /users/create" do
    before do
      post "/users/create", :user => { :name => "Carl Sagan", :email => "carl@sagan.org", :username => "carlsagan" }, :password => "foobar"
    end

    it "redirects correctly" do
      response.should be_redirect
      response.location.should == "#{site}/"
    end

    it "creates a User" do
      u = User.find_by_email("carl@sagan.org")

      u.should_not be_nil
      u.password.should == "foobar"
    end
  end

  describe "GET /settings" do
    before do
      get "/settings"
    end

    it "is ok" do
      response.should be_ok
    end
  end

  describe "PATCH /users/update" do
    before do
      patch "/users/update", :id => user.id, :user => { :name => "Carl Sagan" }
    end

    it "redirects correctly" do
      response.should be_redirect
      response.location.should == "#{site}/settings"
    end

    it "modifies a User" do
      u = User.find(user.id)

      u.name.should == "Carl Sagan"
    end
  end

  describe "DELETE /users/destroy" do
    before do
      delete "/users/destroy", :id => user.id
    end

    it "redirects correctly" do
      response.should be_redirect
      response.location.should == "#{site}/"
    end

    it "destroys a User" do
      User.find(user.id).should be_nil
    end
  end

  describe "GET /:username" do
    before do
      get "/#{user.username}"
    end

    it "is ok" do
      response.should be_ok
    end
  end
end