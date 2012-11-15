require "spec_helper"

describe "Sessions" do
  describe "GET /sessions/new" do
    before do
      get "/sessions/new"
    end

    it "should be ok" do
      response.should be_ok
    end
  end

  describe "GET /sessions/destroy" do
    before do
      # sign in

      get "/sessions/destroy"
    end

    it "should redirect correctly" do
      response.should be_redirect
      response.location.should == "#{site}/"
    end
  end
end