require 'spec_helper'

describe 'Notes (API)' do
  let(:user) { create(:user) }
  let(:note) { create(:note) }

  describe 'PATCH /api/notes/update.json' do
    before do
      opts = {
        :author => user.id,
        :note => {
          :id => note.id,
          :title => 'Natural History'
        }
      }

      patch '/api/notes/update.json', opts
    end

    let(:body) { JSON.parse(response.body) }

    it { response.should be_ok }
    it { body['status'].should eql 200 }
    it { body['result']['note']['id'].should eql note.id.to_s }
    it { body['result']['note']['title'].should eql 'Natural History' }
  end
end
