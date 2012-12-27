require 'spec_helper'

describe "Sessions" do
  let(:user) { create(:user) }

  describe "GET /login" do
    before do
      get "/login"
    end

    it { response.should be_ok }
  end

  describe "POST /sessions/create" do
    before do
      post "/sessions/create", :user => { :email => user.email, :password => "foobar" }
    end

    it "sets a session" do
      pending "find way to retrieve sessions from rack/test"
    end

    describe "redirects" do
      it { response.should be_redirect }
      it { response.location.should include("/") }
    end
  end

  describe "GET /logout" do
    before do
      get "/logout"
    end

    it "unsets a session" do
      pending "find way to retrieve sessions from rack/test"
    end

    describe "redirects" do
      it { response.should be_redirect }
      it { response.location.should include("/") }
    end
  end
end 