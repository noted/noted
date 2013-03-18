require 'spec_helper'

describe UserCreate do
  let(:user) do
    UserCreate.run({:name => "Carl Sagan", :email => "carl@sagan.org", :username => "carl", :password => "foobar"})
  end

  it { user.success?.should be_true }
  it { user.result.should be_an_instance_of User }
end
