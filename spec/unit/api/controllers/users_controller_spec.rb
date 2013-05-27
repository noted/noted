require 'spec_helper'

describe 'Users (API)' do
  let(:user) { create(:user) }

  describe 'GET /api/users/search.json' do
    before do
      get "/api/users/search.json?query=#{user.username}"
    end

    let(:results) do
      {
        'value' => user.username,
        'data' => user.id.to_s
      }
    end

    let(:body) { JSON.parse(response.body) }

    it { response.should be_ok }
    it { body['query'].should eql user.username }
    it { body['suggestions'].should include results }
  end
end
