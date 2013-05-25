require 'spec_helper'

describe Tinder::Room do
  before do
    FakeWeb.register_uri(:get, "https://mytoken:X@test.campfirenow.com/room/80749.json",
      :body => fixture('rooms/show.json'), :content_type => "application/json")
    @room = Tinder::Room.new(Tinder::Connection.new('test', :token => 'mytoken'), 'id' => 80749)

    # Get EventMachine out of the way. We could be using em-spec, but seems like overkill
    require 'twitter/json_stream'
    module EventMachine; def self.run; yield end end
    EventMachine.stub!(:reactor_running?).and_return(true)
    @stream = mock(Twitter::JSONStream)
    @stream.stub!(:each_item)
  end

  describe "join" do
    FakeWeb.register_uri(:post, "https://mytoken:X@test.campfirenow.com/room/80749/join.json", :status => '200')

    it "should post to join url" do
      @room.join
    end
  end

  describe "leave" do
    before do
      FakeWeb.register_uri(:post, "https://mytoken:X@test.campfirenow.com/room/80749/leave.json", :status => '200')
    end

    it "should post to leave url" do
      @room.leave
    end

    it "stops listening" do
      @room.should_receive(:stop_listening)
      @room.leave
    end
  end

  describe "lock" do
    before do
      FakeWeb.register_uri(:post, "https://mytoken:X@test.campfirenow.com/room/80749/lock.json", :status => '200')
    end

    it "should post to lock url" do
      @room.lock
    end
  end

  describe "unlock" do
    before do
      FakeWeb.register_uri(:post, "https://mytoken:X@test.campfirenow.com/room/80749/unlock.json", :status => '200')
    end

    it "should post to unlock url" do
      @room.unlock
    end
  end

  describe "guest_url" do
    it "should use guest_invite_code if active" do
      @room.stub!(:guest_access_enabled? => true, :guest_invite_code => '123')
      @room.guest_url.should == "https://test.campfirenow.com/123"
    end

    it "should return nil when guest access is not enabled" do
      @room.stub!(:guest_access_enabled?).and_return(false)
      @room.guest_url.should be_nil
    end
  end

  it "should set guest_invite_code" do
    @room.guest_invite_code.should == "90cf7"
  end

  it "should set guest_access_enabled?" do
    @room.guest_access_enabled?.should be_true
  end

  describe "name=" do
    it "should put to update the room" do
      FakeWeb.register_uri(:put, "https://mytoken:X@test.campfirenow.com/room/80749.json",
        :status => '200')
      @room.name = "Foo"
    end
  end

  describe "listen" do
    it "should get from the streaming url" do
      Twitter::JSONStream.should_receive(:connect).
        with({:host=>"streaming.campfirenow.com", :path=>"/room/80749/live.json", :auth=>"mytoken:X", :timeout=>6, :ssl=>true}).
        and_return(@stream)
      @room.listen { }
    end

    it "should raise an exception if no block is given" do
      lambda {
        @room.listen
      }.should raise_error(ArgumentError, "no block provided")
    end

    it "marks the room as listening" do
      Twitter::JSONStream.stub!(:connect).and_return(@stream)
      lambda {
        @room.listen { }
      }.should change(@room, :listening?).from(false).to(true)
    end
  end

  describe "stop_listening" do
    before do
      Twitter::JSONStream.stub!(:connect).and_return(@stream)
      @stream.stub!(:stop)
    end

    it "changes a listening room to a non-listening room" do
      @room.listen { }
      lambda {
        @room.stop_listening
      }.should change(@room, :listening?).from(true).to(false)
    end

    it "tells the json stream to stop" do
      @room.listen { }
      @stream.should_receive(:stop)
      @room.stop_listening
    end

    it "does nothing if the room is not listening" do
      @room.listen { }
      @room.stop_listening
      @room.stop_listening
    end
  end
end
