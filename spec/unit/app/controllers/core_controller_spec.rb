require 'spec_helper'

describe "Core" do
  describe "GET /" do
    before do
      get "/"
    end

    it "is ok" do
      response.should be_ok
    end
  end
end