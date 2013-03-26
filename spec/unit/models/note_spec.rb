require "spec_helper"

describe Note do
  let(:note)    { create(:note) }
  let(:project) { note.project }
  let(:user)    { project.user }
  let(:other)   { create(:user) }

  it { note.should be_valid }

  describe "#url" do
    it { note.url.should eql("/#{user.username}/#{project.permalink}/notes/#{note.permalink}") }
  end

  describe "#permalink!" do
    it { note.permalink.should eql(Base32::Crockford.encode(Note.count + 1)) }
  end

  describe "#tags_str" do
    before do
      note.tags << Tag.new(:text => "foobar")
      note.tags << Tag.new(:text => "barfoo")
    end

    it { note.tags_str.should eql "foobar,barfoo" }
  end
end
