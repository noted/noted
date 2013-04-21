require "spec_helper"

describe Note do
  let(:note)     { create(:note) }
  let(:project)  { note.project }
  let(:user)     { project.user }
  let(:staff)    { create(:user, :staff) }
  let(:outsider) { create(:user) }
  let(:collaborator) do
    u = create(:user)

    project.collaborator_ids << u.id
    project.save

    u
  end

  it { note.should be_valid }

  describe "#url" do
    it { note.url.should eql("/#{user.username}/#{project.permalink}/notes/#{note.permalink}") }
  end

  describe "#permalink!" do
    it { note.permalink.should eql(Base32::Crockford.encode(Von.count('notes').total)) }
  end

  describe "#tags=" do
    before do
      note.tags = "foo,bar"
    end

    it { note.tags_str.should eql "foo,bar" }
  end

  describe "#tags_str" do
    before do
      note.tags << Tag.new(:text => "foobar")
      note.tags << Tag.new(:text => "barfoo")
    end

    it { note.tags_str.should eql "foobar,barfoo" }
  end

  describe "#creatable_by?" do
    it { note.creatable_by?(user).should be_true }
    it { note.creatable_by?(collaborator).should be_true }
    it { note.creatable_by?(outsider).should be_false }
    it { note.creatable_by?(staff).should be_true }
  end

  describe "#updatable_by?" do
    it { note.updatable_by?(user).should be_true }
    it { note.updatable_by?(collaborator).should be_true }
    it { note.updatable_by?(outsider).should be_false }
    it { note.updatable_by?(staff).should be_true }
  end

  describe "#destroyable_by?" do
    it { note.destroyable_by?(user).should be_true }
    it { note.destroyable_by?(collaborator).should be_true }
    it { note.destroyable_by?(outsider).should be_false }
    it { note.destroyable_by?(staff).should be_true }
  end
end
