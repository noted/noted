require 'test_helper'
require 'models'

class BelongsToProxyTest < Test::Unit::TestCase
  def setup
    @post_class = Doc()
    @comment_class = Doc do
      key :post_id, ObjectId
    end

    @comment_class.belongs_to :post, :class => @post_class
  end

  should "default to nil" do
    @comment_class.new.post.nil?.should be_true
  end

  should "return nil instead of a proxy" do
    nil.should === @comment_class.new.post
  end

  should "have boolean presence method" do
    comment = @comment_class.new(:name => 'Foo!')
    comment.post?.should be_false

    comment.post = @post_class.new(:name => 'mongomapper')
    comment.post?.should be_true
  end

  should "allow overriding association methods" do
    @comment_class.class_eval do
      def post?
        super
      end
    end

    instance = @comment_class.new
    instance.post?.should be_false
    instance.post = @post_class.new
    instance.post?.should be_true
  end

  should "be able to replace the association" do
    post = @post_class.new(:name => 'mongomapper')
    comment = @comment_class.new(:name => 'Foo!', :post => post)
    comment.save.should be_true

    comment = comment.reload
    comment.post.should == post
    comment.post.nil?.should be_false
  end
  
  should "not reload the association when replacing" do
    post = @post_class.new(:name => 'mongomapper')
    comment = @comment_class.new(:name => 'Foo!', :post => post)
    comment.post.proxy_target.object_id.should == post.object_id
  end

  should "properly assign the associated object when assigning the association with create" do
    child_class = Doc('Child')
    parent_class = Doc('Parent')
    
    parent_class.one :child, :class => child_class
    child_class.belongs_to :parent, :class => parent_class
    
    child = child_class.create(:parent => parent_class.create)
    child.parent.child.should == child
  end

  should "generate a new proxy when replacing the association" do
    post1 = @post_class.create(:name => 'post1')
    post2 = @post_class.create(:name => 'post2')

    comment = @comment_class.new(:name => 'Foo!', :post => post1)
    comment.save.should be_true


    comment = comment.reload
    comment.post.should == post1
    comment.post.nil?.should be_false

    original_post = comment.post
    original_post.name.should == 'post1'

    comment.post = post2
    comment.post.name.should == 'post2'
    original_post.name.should == 'post1'
  end

  should "unset the association" do
    post = @post_class.new(:name => 'mongomapper')
    comment = @comment_class.new(:name => 'Foo!', :post => post)
    comment.save.should be_true

    comment = comment.reload
    comment.post = nil
    comment.post.nil?.should be_true
  end

  should "return nil if id set but document not found" do
    id = BSON::ObjectId.new
    @comment_class.new(:name => 'Foo', :post_id => id).post.nil?.should be_true
  end

  should "define foreign key if it doesn't exist" do
    @category_class = Doc()
    @post_class.belongs_to :category, :class => @category_class

    @post_class.key?(:category_id).should be_true
  end

  should "not define foreign key if it already exists" do
    @category_class = Doc()
    @post_class.key :category_id, String
    @post_class.belongs_to :category, :class => @category_class

    @post_class.keys['category_id'].type.should == String
  end

  context ":dependent" do
    setup do
      # FIXME: make use of already defined models
      class ::Property
        include MongoMapper::Document
      end
      Property.collection.remove

      class ::Thing
        include MongoMapper::Document
        key :name, String
      end
      Thing.collection.remove
    end

    teardown do
      Object.send :remove_const, 'Property' if defined?(::Property)
      Object.send :remove_const, 'Thing' if defined?(::Thing)
    end

    context "=> destroy" do
      setup do
        Property.key :thing_id, ObjectId
        Property.belongs_to :thing, :dependent => :destroy
        Thing.many :properties

        @thing = Thing.create(:name => "Tree")
        @property1 = Property.create
        @property2 = Property.create
        @property3 = Property.create
        @thing.properties << @property1
        @thing.properties << @property2
        @thing.properties << @property3
      end

      should "not execute on a belongs_to association" do
        Thing.count.should == 1
        @property1.destroy
        Thing.count.should == 1
      end
    end
  end

  should "be able to build" do
    @comment_class.belongs_to :post, :class => @post_class

    comment = @comment_class.create
    post = comment.build_post(:title => 'Hello, world!')
    comment.post.should be_instance_of(@post_class)
    comment.post.should be_new
    comment.post.title.should == 'Hello, world!'
    comment.post.should == post
    comment.post_id.should == post.id
  end

  should "be able to create" do
    @comment_class.belongs_to :post, :class => @post_class

    comment = @comment_class.create
    post = comment.create_post(:title => 'Hello, world!')
    comment.post.should be_instance_of(@post_class)
    comment.post.should_not be_new
    comment.post.title.should == 'Hello, world!'
    comment.post.should == post
    comment.post_id.should == post.id
  end

  context "#create!" do
    setup do
      @post_class.key :title, String, :required => true
      @comment_class.belongs_to :post, :class => @post_class
    end

    should "raise exception if invalid" do
      comment = @comment_class.create
      assert_raises(MongoMapper::DocumentNotValid) do
        comment.create_post!
      end
    end

    should "work if valid" do
      comment = @comment_class.create
      post = comment.create_post!(:title => 'Hello, world!')
      comment.post.should be_instance_of(@post_class)
      comment.post.should_not be_new
      comment.post.title.should == 'Hello, world!'
      comment.post.should == post
      comment.post_id.should == post.id
    end
  end

  context 'autosave' do
    should 'not be true by default' do
      @comment_class.associations[:post].options[:autosave].should_not be_true
    end

    should 'save parent changes when true' do
      @comment_class.associations[:post].options[:autosave] = true

      comment = @comment_class.create
      post = comment.create_post(:title => 'Hello, world!')

      comment.post.attributes = {:title => 'Hi, world.'}
      comment.save

      post.reload.title.should == 'Hi, world.'
    end

    should 'not save parent changes when false' do
      comment = @comment_class.create
      post = comment.create_post(:title => 'Hello, world!')

      comment.post.attributes = {:title => 'Hi, world.'}
      comment.save

      post.reload.title.should == 'Hello, world!'
    end
  end
end