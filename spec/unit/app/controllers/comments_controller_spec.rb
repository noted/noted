require 'spec_helper'

describe 'Comments' do
  let(:comment) { create(:comment) }
  let(:note)    { create(:note) }
  let(:project) { note.project }
  let(:user)    { project.user }

  before do
    note.comments << comment
    note.save

    comment.save
  end

  describe 'POST /comments/create' do
    before do
      post '/comments/create', :comment => { :_type => 'Note', :_id => note.id.to_s, :body => 'Foobar', :author => user.id.to_s }, :redirect => project.url
    end

    it { response.should be_redirect }
    it { response.location.should include "#{project.url}" }

    it { note.comments.should_not be_blank }
  end

  describe 'DELETE /comments/destroy' do
    let(:id) { comment.id }

    before do
      delete '/comments/destroy', :comment => { :id => comment.id.to_s }, :redirect => project.url
    end

    it { response.should be_redirect }
    it { response.location.should include project.url }

    it { Comment.find(id).should be_nil }
  end
end
