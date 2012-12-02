require 'spec_helper'

describe "Sessions" do
  let(:user) { create(:user) }

  describe "GET /login" do
    before do
      get "/login"
    end

    it "is ok" do
      response.should be_ok
    end
  end

  describe "POST /sessions/create" do
  end

  describe "GET /logout" do
  end
end