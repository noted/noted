require 'helper'


describe CIJoe::Queue do
  it 'can disable a queue' do
    subject = CIJoe::Queue.new(false)
    subject.append_unless_already_exists("test")
    subject.waiting?.must_equal false
  end

  it 'can add two items to a queue' do
    subject = CIJoe::Queue.new(true)
    subject.append_unless_already_exists("test")
    subject.append_unless_already_exists(nil)

    subject.waiting?.must_equal true
    subject.next_branch_to_build.must_equal 'test'
    subject.next_branch_to_build.must_be_nil
    subject.waiting?.must_equal false
  end

  it 'squashes two duplicate items in the queue' do
    subject = CIJoe::Queue.new(true)
    subject.append_unless_already_exists("test")
    subject.append_unless_already_exists("test")

    subject.waiting?.must_equal true
    subject.next_branch_to_build.must_equal 'test'
    subject.waiting?.must_equal false
  end
end
