require "spec_helper"

describe "Notes" do
  let(:user)    { create(:user) }
  let(:project) { create(:project) }
  let(:note)    { create(:note) }

  describe "GET /:user/:project/notes" do
    before do
      get "/#{project.url}/notes"
    end

    it "is ok" do
      response.should be_ok
    end
  end

  describe "GET /:user/:project/notes/new" do
    before do
      get "/#{project.url}/notes/new"
    end

    it "is ok" do
      response.should be_ok
    end
  end

  describe "POST /notes/create" do
    before do
      post "/notes/create", :project => project.id, :author => user.id
    end

    context "redirects" do
      it { response.should be_redirect }
    end
  end

  describe "GET /:user/:project/notes/:note" do
    before do
      get "/#{note.url}"
    end

    it "is ok" do
      response.should be_ok
    end
  end

  describe "PATCH /notes/update" do
    before do
      patch "/notes/update", :id => note.id, :author => user.id, :note => { :title => "Natural History" }

      note.reload
    end

    context "redirects" do
      it { response.should be_redirect }
      it { response.location.should include("/#{user.username}/#{project.permalink}/notes") }
    end

    it "updates a Note" do
      note.title.should eql("Natural History")
    end
  end

  describe "DELETE /notes/destroy" do
    before do
      delete "/notes/destroy", :id => note.id
    end

    context "redirects" do
      it { response.should be_redirect }
      it { response.location.should include("/#{user.username}/#{project.permalink}/notes")}
    end
  end
end