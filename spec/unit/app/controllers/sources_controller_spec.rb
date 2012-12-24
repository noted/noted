require "spec_helper"

describe "Sources" do
  let(:user)    { create(:user) }
  let(:project) { create(:project) }
  let(:source)  { create(:source) }

  describe "GET /:user/:project/sources" do
    before do
      get "#{project.url}/sources"
    end

    it "is ok" do
      response.should be_ok
    end
  end

  describe "GET /:user/:project/sources/new" do
    before do
      get "/#{project.url}/sources/new"
    end

    it "is ok" do
      response.should be_ok
    end
  end

  describe "POST /sources/create" do
    before do
      post "/sources/create", :user => user.id, :project => project.id, :author => user.id, :source => Data.book
    end

    context "redirects" do
      it { response.should be_redirect }
      it { response.location.should include("/#{user.username}/#{project.permalink}/sources/#{source.permalink}") }
    end

    it "creates a Source" do
      Source.find_by_attributes(Data.book).should_not be_nil
    end
  end

  describe "GET /:user/:project/sources/:source" do
    before do
      get "/#{source.url}"
    end

    it "is ok" do
      response.should be_ok
    end
  end

  describe "PATCH /sources/update" do
    before do
      patch "/sources/update", :id => source.id, :author => user.id, :source => { :attributes => { :title => "H2G2" } }
      
      source.reload
    end

    context "redirects" do
      it { response.should be_redirect }
      it { response.location.should include("/#{user.username}/#{project.permalink}/sources") }
    end

    it "updates the Source" do
      source.attributes.title.should eql("H2G2")
    end
  end

  describe "DELETE /sources/destroy" do
    before do
      delete "/sources/destroy", :id => source.id
    end

    context "redirects" do
      it { response.should be_redirect }
      it { response.location.should include("/#{user.permalink}/#{project.permalink}/sources") }
    end

    it "destroys the Source" do
      Source.find_by_name("The Hitchhiker's Guide to the Galaxy").should be_nil
    end
  end
end
