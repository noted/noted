require "spec_helper"

describe "Dashboard" do
  describe "GET /dashboard" do
    before do
      get "/dashboard"
    end

    it "should be ok" do
      response.should be_ok
    end
  end 
end