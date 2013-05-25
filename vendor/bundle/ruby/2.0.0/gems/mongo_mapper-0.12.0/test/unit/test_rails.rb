require 'test_helper'

class TestRails < Test::Unit::TestCase
  context "Document" do
    setup do
      @klass = Doc('Post') do
        key :foo, String
      end
    end

    context "Class methods" do
      should "alias has_many to many" do
        @klass.should respond_to(:has_many)
      end

      should 'pass on block given in has_many' do
        @klass.class_eval do
          has_many :posts do
            def foo_bars; true; end
          end
        end

        @klass.new.posts.should respond_to(:foo_bars)
      end

      should "alias has_one to one" do
        @klass.should respond_to(:has_one)
      end

      should "have column names" do
        @klass.column_names.sort.should == ['_id', 'foo']
      end
    end

    context "Instance methods" do
      setup do
        @klass.class_eval do
          def bar=(value)
            write_attribute(:foo, value)
          end

          def bar_before_type_cast
            read_attribute_before_type_cast(:foo)
          end

          def bar
            read_attribute(:foo)
          end
        end
      end

      should "alias new_record? to new?" do
        @klass.new.should be_new_record
      end

      should "be able to read key with read_attribute" do
        @klass.new(:foo => 'Bar').bar.should == 'Bar'
      end

      should "be able to read key before type cast with read_attribute_before_type_cast" do
        @klass.new(:foo => 21).bar_before_type_cast.should == 21
        @klass.new(:foo => 21).bar.should == '21'
      end

      should "be able to write key with write_attribute" do
        @klass.new(:bar => 'Setting Foo').foo.should == 'Setting Foo'
      end

      context '#to_param' do
        should "be nil if not persisted" do
          @klass.new.tap do |doc|
            doc.to_param.should be_nil
          end
        end

        should "array representation of id if persisted" do
          @klass.create.tap do |doc|
            doc.to_param.should == doc.id.to_s
          end
        end
      end

      context '#to_key' do
        should "be nil if not persisted" do
          @klass.new.tap do |doc|
            doc.to_key.should be_nil
          end
        end

        should "array representation of id if persisted" do
          @klass.create.tap do |doc|
            doc.to_key.should == [doc.id]
          end
        end
      end
    end
  end

  context "EmbeddedDocument" do
    setup do
      @klass = EDoc('Post') { key :foo, String }
    end

    context "Class methods" do
      should "alias has_many to many" do
        @klass.should respond_to(:has_many)
      end

      should "alias has_one to one" do
        @klass.should respond_to(:has_one)
      end

      should "have column names" do
        @klass.column_names.sort.should == ['_id', 'foo']
      end
    end

    context "Instance methods" do
      setup do
        @klass.class_eval do
          def bar=(value)
            write_attribute(:foo, value)
          end

          def bar_before_type_cast
            read_attribute_before_type_cast(:foo)
          end

          def bar
            read_attribute(:foo)
          end
        end
      end

      should "alias new_record? to new?" do
        @klass.new.should be_new_record
      end

      should "be able to read key with read_attribute" do
        @klass.new(:foo => 'Bar').bar.should == 'Bar'
      end

      should "be able to read key before type cast with read_attribute_before_type_cast" do
        @klass.new(:foo => 21).bar_before_type_cast.should == 21
        @klass.new(:foo => 21).bar.should == '21'
      end

      should "be able to write key with write_attribute" do
        @klass.new(:bar => 'Setting Foo').foo.should == 'Setting Foo'
      end

      context '#to_param' do
        should "be nil if not persisted" do
          @klass.new.tap do |doc|
            doc.to_param.should be_nil
          end
        end

        should "array representation of id if persisted" do
          @klass.new.tap do |doc|
            doc.expects(:persisted?).returns(true)
            doc.to_param.should == doc.id.to_s
          end
        end
      end

      context '#to_key' do
        should "be nil if not persisted" do
          @klass.new.tap do |doc|
            doc.to_key.should be_nil
          end
        end

        should "array representation of id if persisted" do
          @klass.new.tap do |doc|
            doc.expects(:persisted?).returns(true)
            doc.to_key.should == [doc.id]
          end
        end
      end
    end
  end
end
