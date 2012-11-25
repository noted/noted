require 'spec_helper'

describe "Users" do
  let(:user) { create(:user) }

  describe "GET /join" do
    before do
      get '/join'
    end

    it "should be ok" do
      response.should be_ok
    end
  end

  describe "POST /users/create" do
    before do
      post '/users/create', :user => { :name => "Carl Sagan", :email => "carl@sagan.org", :username => "carlsagan" }, :password => "foobar"
    end

    it "should redirect correctly" do
      response.should be_redirect
      response.location.should == "#{site}/"
    end

    it "should create a User" do
      u = User.find_by_email("carl@sagan.org")

      u.should_not be_nil
      u.password.should == "foobar"
    end
  end

  describe "GET /settings" do
    before do
      login_as user
      get '/settings'
    end

    it "should be ok" do
      response.should be_ok
    end
  end

  describe "PUT /users/modify" do
    before do
      put '/users/modify', :id => user.id, :user => { :name => "Carl Sagan" }
    end

    it "should redirect correctly" do
      response.should be_redirect
      response.location.should == "#{site}/settings"
    end

    it "should modify a User" do
      u = User.find(user.id)

      u.name.should == "Carl Sagan"
    end
  end

  describe "DELETE /users/destroy" do
    before do
      delete "/users/destroy", :id => user.id
    end

    it "should redirect correctly" do
      response.should be_redirect
      response.location.should == "#{site}/"
    end

    it "should destroy a User" do
      User.find(user.id).should be_nil
    end
  end

  describe "GET /:username" do
    before do
      get "/#{user.username}"
    end

    it "should be ok" do
      response.should be_ok
    end
  end
end