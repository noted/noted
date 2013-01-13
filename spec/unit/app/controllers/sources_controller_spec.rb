require "spec_helper"

describe "Sources" do
  let(:source)  { create(:source) }
  let(:project) { source.project }
  let(:user)    { project.user }

  describe "GET /:user/:project/sources" do
    before do
      get "#{user.username}/#{project.permalink}/sources"
    end

    it { response.should be_ok }
  end

  describe "GET /:user/:project/sources/new" do
    before do
      get "#{user.username}/#{project.permalink}/sources/new"
    end

    it { response.should be_ok }
  end

  describe "POST /sources/create" do
    before do
      data = { :data => { :title => "The Space Chronicles" } }

      post "/sources/create", :user => user.id, :project => project.id, :author => user.id, :source => data
    end

    let(:s) { Source.where(:data => {:title => "The Space Chronicles"}).first }

    describe "redirects" do

      it { response.should be_redirect }
      it { response.location.should include("/#{user.username}/#{project.permalink}/sources/#{s.permalink}") }
    end

    describe "database" do
      it { s.should_not be_nil }
      it { s.creator.should eql(user) }
    end
  end

  describe "GET /:user/:project/sources/:source" do
    before do
      get "/#{user.username}/#{project.permalink}/sources/#{source.permalink}"
    end

    it "is ok" do
      response.should be_ok
    end
  end

  describe "PATCH /sources/update" do
    before do
      patch "/sources/update", :id => source.id, :author => user.id, :source => { :data => { :title => "H2G2" } }

      source.reload
    end

    describe "redirects" do
      it { response.should be_redirect }
      it { response.location.should include("/#{user.username}/#{project.permalink}/sources") }
    end

    describe "database" do
      it { source.data[:title].should eql("H2G2") }
      it { source.updater.should eql(user) }
    end
  end

  describe "DELETE /sources/destroy" do
    before do
      delete "/sources/destroy", :id => source.id
    end

    describe "redirects" do
      it { response.should be_redirect }
      it { response.location.should include("/#{user.username}/#{project.permalink}/sources") }
    end

    it "destroys the Source" do
      Source.find_by_name("The Hitchhiker's Guide to the Galaxy").should be_nil
    end
  end
end
