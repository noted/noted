require 'test_helper'
require 'rack/test'

class IdentityMapMiddlewareTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    @app ||= Rack::Builder.new do
      use MongoMapper::Middleware::IdentityMap

      map "/" do
        run lambda {|env| [200, {}, []] }
      end

      map "/fail" do
        run lambda {|env| raise "FAIL!" }
      end
    end.to_app
  end

  context "" do
    setup do
      @enabled = MongoMapper::Plugins::IdentityMap.enabled
      MongoMapper::Plugins::IdentityMap.enabled = false
    end

    teardown do
      MongoMapper::Plugins::IdentityMap.enabled = @enabled
    end

    should "delegate" do
      called = false
      mw = MongoMapper::Middleware::IdentityMap.new lambda { |env|
        called = true
        [200, {}, nil]
      }
      mw.call({})
      called.should be_true
    end

    should "enable identity map during delegation" do
      mw = MongoMapper::Middleware::IdentityMap.new lambda { |env|
        MongoMapper::Plugins::IdentityMap.should be_enabled
        [200, {}, nil]
      }
      mw.call({})
    end

    class Enum < Struct.new(:iter)
      def each(&b)
        iter.call(&b)
      end
    end

    should "enable IM for body each" do
      mw = MongoMapper::Middleware::IdentityMap.new lambda { |env|
        [200, {}, Enum.new(lambda { |&b|
          MongoMapper::Plugins::IdentityMap.should be_enabled
          b.call "hello"
        })]
      }
      body = mw.call({}).last
      body.each { |x| x.should eql('hello') }
    end

    should "disable IM after body close" do
      mw = MongoMapper::Middleware::IdentityMap.new lambda { |env| [200, {}, []] }
      body = mw.call({}).last
      MongoMapper::Plugins::IdentityMap.should be_enabled
      body.close
      MongoMapper::Plugins::IdentityMap.should_not be_enabled
    end

    should "clear IM after body close" do
      mw = MongoMapper::Middleware::IdentityMap.new lambda { |env| [200, {}, []] }
      body = mw.call({}).last

      MongoMapper::Plugins::IdentityMap.repository['hello'] = 'world'
      MongoMapper::Plugins::IdentityMap.repository.should_not be_empty

      body.close

      MongoMapper::Plugins::IdentityMap.repository.should be_empty
    end

    context "with a successful request" do
      should "clear the identity map" do
        MongoMapper::Plugins::IdentityMap.expects(:clear).twice
        get '/'
      end
    end

    context "when the request raises an error" do
      should "clear the identity map" do
        MongoMapper::Plugins::IdentityMap.expects(:clear).once
        get '/fail' rescue nil
      end
    end
  end
end

# class IdentityMapMiddlewareTest < Test::Unit::TestCase
#   include Rack::Test::Methods

#   def app
#     @app ||= Rack::Builder.new do
#       use MongoMapper::Middleware::IdentityMap
#       map "/" do
#         run lambda {|env| [200, {}, []] }
#       end
#       map "/fail" do
#         run lambda {|env| raise "FAIL!" }
#       end
#     end.to_app
#   end

#   context "with a successful request" do
#     should "clear the identity map" do
#       MongoMapper::Plugins::IdentityMap.expects(:clear).twice
#       get '/'
#     end
#   end

#   context "when the request raises an error" do
#     should "clear the identity map" do
#       MongoMapper::Plugins::IdentityMap.expects(:clear).twice
#       get '/fail' rescue nil
#     end
#   end


# end
