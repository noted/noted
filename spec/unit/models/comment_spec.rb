require "spec_helper"

describe Comment do
  let(:note){ Note.create(:title => "Foobar", :comments => [ { "text" => "Foo to the bar" } ] ) } # Use factories in the future.
  
  it "can be instantiated" do
    note.comments.should_not be_blank
  end
end
