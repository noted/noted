require "spec_helper"

describe Institution do
	let(:user) { create(:user) }
  let(:institution) { create(:institution) }

  it "can be instantiated" do
    institution.should_not be_nil
  end

  it "can have an owner" do
  	user.institutions << institution
  	institution.user_id.should == user.id
  end
end
