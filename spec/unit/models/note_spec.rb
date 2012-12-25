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
end
