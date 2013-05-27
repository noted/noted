require 'spec_helper'

describe 'Notes' do
  let(:note)    { create(:note) }
  let(:project) { note.project }
  let(:user)    { project.user }

  before do
    get project.url
  end

  describe 'POST /notes/create' do
    before do
      post '/notes/create', :project => project.id, :author => user.id
    end

    it { response.should be_redirect }
    it { response.location.should include "#{project.url}" }

    it { project.notes.should_not be_blank }
  end

  describe 'GET /:user/:project/notes/:note' do
    before do
      get note.url
    end

    it { response.should be_ok }
  end

  describe 'PATCH /notes/update' do
    before do
      patch '/notes/update', :author => user.id, :note => { :id => note.id, :title => 'Natural History' }

      note.reload
    end

    it { response.should be_redirect }
    it { response.location.should include "/#{user.username}/#{project.permalink}" }

    it { note.title.should eql 'Natural History' }
    it { note.updater.should eql user }
  end

  describe 'DELETE /notes/destroy' do
    let(:id) { note.id }

    before do
      delete '/notes/destroy', :author => user.id, :note => { :id => note.id }
    end

    it { response.should be_redirect }
    it { response.location.should include "/#{user.username}/#{project.permalink}" }

    it { Note.find(id).deleted_at.should_not be_nil }
  end
end
