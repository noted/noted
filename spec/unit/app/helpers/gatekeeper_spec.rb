require "spec_helper"

describe Gatekeeper do
  let(:user) { create(:user) }

  describe "#current_user" do
    it "returns the correct User"
  end

  describe "#login" do
    it "sets the session"
  end

  describe "#logged_in?" do
    context "with session set" do
      it "returns true"
    end

    context "with session not set" do
      it "returns false"
    end
  end
end