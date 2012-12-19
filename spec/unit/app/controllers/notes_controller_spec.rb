require "spec_helper"

describe "Notes" do
  let(:user)    { create(:user) }
  let(:project) { create(:project) }
  let(:note)    { create(:note) }

  describe "GET /:user/:project/notes" do
    before do
      get "/#{user.username}/#{project.permalink}/notes"
    end

    it "is ok" do
      response.should be_ok
    end
  end

  describe "POST /notes/create" do
    before do
      post "/notes/create", :project_id => project.id
    end

    it "redirects" do
      response.should be_redirect
    end
  end

  describe "GET /:user/:project/notes/:note" do
    before do
      get "/#{user.username}/#{project.permalink}/notes/#{note.permalink}"
    end

    it "is ok" do
      response.should be_ok
    end
  end

  describe "PATCH /notes/update" do
    before do
      patch "/notes/update", :id => note.id, :note => { :title => "Natural History" }

      note.reload
    end

    it "redirects" do
      response.should be_redirect
      response.location.should include("/#{note.project.user.username}/#{project.permalink}/notes")
    end

    it "updates a Note" do
      note.title.should eql("Natural History")
    end
  end
end