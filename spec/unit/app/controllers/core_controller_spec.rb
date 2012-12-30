require 'spec_helper'

describe "Core" do
  describe "GET /" do
    before do
      get "/"
    end

    it { response.should be_ok }
  end

  describe "GET /explore" do
    before do
      get "/explore"
    end

    it { response.should be_ok }
  end

  describe "GET /features" do
    before do
      get "/features"
    end

    it { response.should be_ok }
  end

  describe "GET /pricing" do
    before do
      get "/pricing"
    end

    it { response.should be_ok }
  end

  describe "GET /documentation" do
    before do
      get "/documentation"
    end

    it { response.should be_ok }
  end

  describe "GET /support" do
    before do
      get "/spoort"
    end

    it { response.should be_ok }
  end
end