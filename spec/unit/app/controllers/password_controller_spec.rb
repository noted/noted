require 'spec_helper'

describe 'Password' do
  let(:user) { create(:user) }

  describe 'GET /password/reset' do
    before do
      get '/password/reset'
    end

    it { response.should be_ok }
  end

  describe 'POST /password/reset' do
    before do
      post '/password/reset', :email => user.email
    end

    it { response.should be_redirect }
  end

  describe 'GET /password/recover/:token' do
    before do
      get "/password/recover/#{user.token}"
    end

    it { response.should be_ok }
  end

  describe 'POST /password/recover' do
    before do
      post '/password/recover', :user => { :id => user.id }, :password => { :password => '13201', :confirm => '13201' }
    end

    it { response.should be_redirect }
    it { User.find(user.id).password.should == '13201' }
  end
end
