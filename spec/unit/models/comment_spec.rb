require "spec_helper"

describe Comment do
  let(:note){ Note.create(:title => "Foobar", :comments => [ { "text" => "Foo to the bar" } ] ) }
  
  it "can be instantiated" do
    note.comments.should_not be_blank
  end
end
