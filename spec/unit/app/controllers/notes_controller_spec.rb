require "spec_helper"

describe "Notes" do
  let(:note)    { create(:note) }
  let(:project) { note.project }
  let(:user)    { project.user }

  describe "GET /:user/:project/notes" do
    before do
      get "/#{user.username}/#{project.permalink}/notes"
    end

    it { response.should be_ok }
  end

  describe "POST /notes/create" do
    before do
      post "/notes/create", :project => project.id, :author => user.id
    end

    context "redirects" do
      it { response.should be_redirect }
      it { response.location.should include("#{project.url}/notes") }
    end

    it { project.notes.should_not be_blank }
  end

  describe "GET /:user/:project/notes/:note" do
    before do
      get "/#{user.username}/#{project.permalink}/notes/#{note.permalink}"
    end

    it { response.should be_ok }
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

    it { note.title.should eql("Natural History") }
  end

  describe "DELETE /notes/destroy" do
    let(:id) { note.id }

    before do
      delete "/notes/destroy", :id => note.id
    end

    context "redirects" do
      it { response.should be_redirect }
      it { response.location.should include("/#{user.username}/#{project.permalink}/notes")}
    end

    it { Note.find(id).should be_nil }
  end
end