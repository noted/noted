require 'spec_helper'

describe Note do
  let(:note) { Note.new(:body => "**Hello, world.**") }
  
  it "can be instantiated" do
    note.should_not be_nil
  end
end
