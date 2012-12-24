require "spec_helper"

describe Note do
  let(:user) { create(:user) }
  let(:note) { create(:note) }

  it "can be instantiated" do
    note.should be_valid
  end

  describe "#create_permalink!" do
    it { note.permalink.should eql(Base32::Crockford.encode(Note.count)) }
  end

  describe "#create_url!" do
    it { note.url.should eql("/#{user.username}/#{project.permalink}/notes/#{note.permalink}") }
  end
end
