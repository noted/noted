require 'spec_helper'

describe "Sessions" do
  let(:user) { create(:user) }

  describe "GET /login" do
    before do
      get "/login"
    end

    it "should be ok" do
      response.should be_ok
    end
  end

  describe "POST /sessions/create" do
    before do
      post "/sessions/create", :user => { :email => user.email, :password => "foobar" }
    end

    it "should redirect correctly" do
      response.should be_redirect
      response.location.should == "#{site}/"
    end

    it "should create a session" do
      get "/"

      response.params[:current_user].should_not be_nil
    end
  end

  describe "GET /logout" do
    before do
      post "/sessions/create", :user => { :email => user.email, :password => "foobar" }
      get "/logout"
    end

    it "should redirect correctly" do
      response.should be_redirect
      response.location.should == "#{site}/"
    end

    it "should destroy a session" do
      get "/"

      response.params[:current_user].should be_nil
    end
  end
end