require 'spec_helper'

describe 'Sessions' do
  let(:user) { create(:user) }

  describe 'GET /login' do
    before do
      get '/login'
    end

    it { response.should be_ok }
  end

  describe 'POST /sessions/create' do
    before do
      post '/sessions/create', :user => { :email => user.email, :password => 'foobar' }
    end

    it { response.headers['Set-Cookie'].should_not be_nil }
    it { response.should be_redirect }
    it { response.location.should eql "#{site}/" }
  end

  describe 'GET /logout' do
    before do
      get '/logout'
    end

    it { response.should be_redirect }
    it { response.location.should eql "#{site}/" }
  end
end
