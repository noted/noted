require 'spec_helper'

describe 'Core' do
  describe 'GET /' do
    before do
      get '/'
    end

    it { response.should be_ok }
  end

  describe 'GET /about' do
    before do
      get '/about'
    end

    it { response.should be_ok }
  end

  describe 'GET /blog' do
    before do
      get '/blog'
    end

    it { response.should be_redirect }
    it { response.location.should eql 'http://blog.getnotedapp.com' }
  end

  describe 'GET /roadmap' do
    before do
      get '/roadmap'
    end

    it { response.should be_ok }
  end

  describe 'GET /support' do
    before do
      get '/support'
    end

    it { response.should be_ok }
  end
end
