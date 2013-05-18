require 'spec_helper'

describe 'Password' do
  let(:user) { create(:user) }

  describe 'GET /password/reset/:token' do
    before do
      get "/password/reset/#{user.token}"
    end

    it { response.should be_ok }
  end

  describe 'POST /password/create' do
    before do
      post '/password/create', :user => { :id => user.id }, :password => { :password => '13201', :confirm => '13201' }
    end

    it { response.should be_redirect }
    it { User.find(user.id).password.should == '13201' }
  end
end
