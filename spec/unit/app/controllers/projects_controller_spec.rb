require 'spec_helper'

describe "Projects" do
  let(:project) { create(:project) }
  let(:user)    { project.user }

  describe "GET /projects/new" do
    before do
      get "/projects/new"
    end

    it { response.should be_ok }
  end

  describe "POST /projects/create" do
    before do
      post "/projects/create", :user => user.id, :author => user.id, :project => { :title => "The Hubble Telescope" }
    end

    it { response.should be_redirect }
    it { response.location.should include("/#{user.username}/the-hubble-telescope") }

    it { Project.find_by_title("The Hubble Telescope").should_not be_nil }
    it { Project.find_by_title("The Hubble Telescope").creator.should eql(user) }
    it { user.projects.should include(Project.find_by_title("The Hubble Telescope")) }
  end

  describe "GET /:username/:project" do
    before do
      get "/#{user.username}/#{project.permalink}"
    end

    it { response.should be_ok }
  end

  describe "GET /:username/:project/settings" do
    before do
      get "/#{user.username}/#{project.permalink}/settings"
    end

    it { response.should be_ok }
  end

  describe "PATCH /projects/update" do
    before do
      patch "/projects/update", :author => user.id, :project => { :id => project.id, :title => "Large Hadron Collider" }

      project.reload
    end

    describe "redirects" do
      it { response.should be_redirect }
      it { response.location.should include("#{project.user.username}/#{project.permalink}") }
    end

    describe "database" do
      it { project.title.should eql("Large Hadron Collider") }
      it { project.updater.should eql(user) }
    end
  end

  describe "DELETE /projects/destroy" do
    before do
      delete "/projects/destroy", :author => user.id, :project => { :id => project.id }
    end

    it { response.should be_redirect }
    it { response.location.should include("/#{project.user.username}") }
    it { Project.find_by_name("The Cosmos").should be_nil }
  end
end
