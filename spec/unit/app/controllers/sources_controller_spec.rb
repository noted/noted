require 'spec_helper'

describe 'Sources' do
  let(:source)  { create(:source) }
  let(:project) { source.project }
  let(:user)    { project.user }

  before do
    get project.url
  end

  describe 'GET /:user/:project/sources/new' do
    before do
      get "#{user.username}/#{project.permalink}/sources/new", {}, 'rack.session' => { :noted => user.id.to_s }
    end

    it { response.should be_ok }
  end

  describe 'POST /sources/create' do
    before do
      data = {
        :book => {
          :title => 'The Space Chronicles',
          :contributors => [
            {
              :role => :author,
              :first => 'Neil',
              :middle => 'deGrasse',
              :last => 'Tyson'
            }
          ],
          :publisher => 'W. W. Norton & Company',
          :year => '2013'
        }
      }

      post '/sources/create', :user => user.id, :project => project.id, :author => user.id, :source => data
    end

    it 'response.should be_redirect'
  end

  describe 'GET /:user/:project/sources/:source' do
    before do
      #get "/#{user.username}/#{project.permalink}/sources/#{source.permalink}"
    end

    it 'response.should be_ok'
  end

  describe 'GET /:user/:project/sources/bibliography' do
    before do
      get "/#{user.username}/#{project.permalink}/sources/bibliography"
    end

    it { response.should be_ok }
  end

  describe 'PATCH /sources/update' do
    before do
      data = {
        :id => source.id.to_s,
        :book => {
          :title => 'The Space Chronicles',
          :contributors => [
            {
              :role => :author,
              :first => 'Neil',
              :middle => 'deGrasse',
              :last => 'Tyson'
            }
          ],
          :publisher => 'Random House',
          :year => '2013'
        }
      }

      patch '/sources/update', :author => user.id, :source => data

      source.reload
    end

    it 'response.should be_redirect'
    it "Source.find(source.id).citation.attributes['publishers'].should eql 'Random House'"
  end

  describe 'DELETE /sources/destroy' do
    let(:id) { source.id }

    before do
      delete '/sources/destroy', :source => { :id => source.id }, :author => user.id
    end

    it { response.should be_redirect }
    it { Source.find(id).deleted_at.should_not be_nil }
  end
end
