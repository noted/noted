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
      post '/join', :user => { :name => "Neil deGrasse Tyson", :email => "neil@hayden.org", :username => "neiltyson" }, :password => "foobar"
    end

    it "should redirect correctly" do
      response.should be_redirect
      response.location.should == "#{site}/"
    end

    it "should create a User" do
      u = User.find(:username => "neiltyson")

      u.should_not be_nil
      u.password.should == "foobar"
    end
  end

  describe "GET /settings" do
    before do
      get '/settings', :current_user => @user
    end

    it "should be ok" do
      response.should be_ok
    end
  end

  describe "PUT /users/modify" do
    before do
      put '/users/modify', :current_user => @user, :id => @user.id, :user => { :name => "Carl Sagan" }
    end

    it "should redirect correctly" do
      response.should be_redirect
      response.location.should == "#{site}/#{@user.username}"
    end

    it "should modify a User" do
      u = User.find(@user.id)

      u.should_not be_nil

      u.name.should == "Carl Sagan"
      u.name.should_not == "Neil deGrasse Tyson"
    end
  end

  describe "DELETE /users/destroy" do
    before do
      delete "/users/destroy", :id => @user.id
    end

    it "should redirect correctly" do
      response.should be_redirect
      response.location.should == "#{site}/"
    end

    it "should destroy a User" do
      User.find(@user.id).should be_nil
    end
  end
end