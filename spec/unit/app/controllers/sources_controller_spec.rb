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
      data = {
        :book => {
          :title => "The Space Chronicles",
          :contributors => [
            {
              :role => :author,
              :first => "Neil",
              :middle => "deGrasse",
              :last => "Tyson"
            }
          ],
          :publisher => "W. W. Norton & Company",
          :year => "2013"
        }
      }

      post "/sources/create", :user => user.id, :project => project.id, :author => user.id, :source => data
    end

    it "response should be redirect (see branch)"
    it "source should be created (see branch)"
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
      #patch "/sources/update", :id => source.id, :author => user.id, :source => { :data => { :title => "H2G2" } }

      source.reload
    end

    it "response should be redirect (see branch)"
    it "source should be updated (see branch)"
  end

  describe "DELETE /sources/destroy" do
    before do
      delete "/sources/destroy", :id => source.id
    end

    it "response should be redirect (see branch)"
    it "source should be destroyed (see branch)"
  end
end
