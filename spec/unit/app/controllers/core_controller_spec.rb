require 'spec_helper'

describe 'Core' do
  describe 'GET /' do
    before do
      get '/'
    end

    it { response.should be_ok }
  end
end
