require 'spec_helper'

describe "Projects" do
  let(:user)    { create(:user) }
  let(:project) { create(:project) }

  describe "GET /projects/new" do
    before do
      get '/projects/new'
    end

    it "should be ok" do
      response.should be_ok
    end
  end

  describe "POST /projects/create" do
    before do
      post '/projects/create', :user_id => user.id, :project => { :title => "The Hubble Telescope", :description => "A giant telescope in space." }
    end

    it "should redirect correctly" do
      response.should be_redirect
      response.location.should == "#{site}/#{user.username}/the-hubble-telescope"
    end

    it "should create a Project" do
      p = Project.find_by_title("The Hubble Telescope")
      
      p.should_not be_nil
      p.permalink.should == "the-hubble-telescope"
    end

    it "should attribute a Project to the User" do
      user.projects.should_not be_nil
      user.projects.should include(Project.find_by_title("The Hubble Telescope"))
    end
  end
end