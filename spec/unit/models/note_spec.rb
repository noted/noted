require 'spec_helper'

describe Note do
  let(:note) { create(:note) }
  
  it "can be instantiated" do
    note.should_not be_nil
  end

  it "can return HTML" do
    note.html.should == "<p><strong>Hello, world.</strong></p>"
  end
end
