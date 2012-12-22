require 'spec_helper'

describe "Projects" do
  let(:user)    { create(:user) }
  let(:project) { create(:project) }

  describe "GET /:username/:project" do
    before do
      get "/#{user.username}/#{project.permalink}"
    end

    it "is ok" do
      response.should be_ok
    end
  end

  describe "GET /projects/new" do
    before do
      get "/projects/new"
    end

    it "is ok" do
      response.should be_ok
    end
  end

  describe "POST /projects/create" do
    before do
      post "/projects/create", :user_id => user.id, :id => { :title => "The Hubble Telescope" }
    end

    context "redirects" do
      it { response.should be_redirect }
      it { response.location.should include("#{user.username}/the-hubble-telescope") }
    end

    context "creates a Project" do
      let(:p) { Project.find_by_title("The Hubble Telescope") }

      it "not nil" do
        p.should_not be_nil
      end

      it "has correct data" do
        p.permalink.should eql("the-hubble-telescope")
      end
    end

    context "attributes a Project to the User" do
      subject { user.projects }

      it { should_not be_nil }
      it { should include(Project.find_by_title("The Hubble Telescope")) }
    end
  end

  describe "GET /:username/:project/settings" do
    before do
      get "/#{user.username}/#{project.permalink}/settings"
    end

    it "is ok" do
      response.should be_ok
    end
  end

  describe "PATCH /projects/update" do
    before do
      patch "/projects/update", :id => project.id, :project => { :title => "The Hubble Telescope" }

      project.reload
    end

    context "redirects" do
      it { response.should be_redirect }
      it { response.location.should include("#{project.user.username}/#{project.permalink}/settings") }
    end

    it "modifies a Project" do
      Project.find(project.id).title.should eql("The Hubble Telescope")
    end
  end

  describe "DELETE /projects/destroy" do
    before do
      delete "/projects/destroy", :id => project.id, :user => project.user.id
    end

    it "destroys a Project" do
      Project.find_by_name("The Cosmos").should be_nil
    end

    context "redirects" do
      it { response.should be_redirect }
      it { response.location.should include("#{project.user.username}") }
    end
  end
end