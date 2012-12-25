require "spec_helper"

describe Source do
  let(:source)  { create(:source) }
  let(:project) { source.project }
  let(:user)    { project.user }

  it "can be instantiated" do
    source.should be_valid
  end

  describe "#format!" do
    it "fills HTML" do
      source.html.should eql("Adams, Douglas. <em>The Salmon of Doubt</em>. New York: Ballantine, 2005. Print.")
    end

    it "fills Markdown" do
      source.markdown.should eql("Adams, Douglas. _The Salmon of Doubt_. New York: Ballantine, 2005. Print.")
    end
  end

  describe "#url" do
    it { source.url.should eql("/#{user.username}/#{project.permalink}/sources/#{source.permalink}")}
  end

  describe "#permalink!" do
    it { source.permalink.should eql(Base32::Crockford.encode(Source.count + 1)) }
  end
end
