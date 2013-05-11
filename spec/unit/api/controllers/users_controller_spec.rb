require 'spec_helper'

describe 'Users (API)' do
  let(:user) { create(:user) }

  describe 'GET /api/users/search.json' do
    before do
      get '/api/users/search.json?query=n'
    end

    it { response.should be_ok }
  end
end
