require "spec_helper"

describe Source do
  let(:user)    { create(:user) }
  let(:project) { create(:project) }
  let(:source)  { create(:source) }

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

  describe "#create_permalink!" do
    it { source.permalink.should eql(Base32::Crockford.encode(Source.count)) }
  end

  describe "#create_url!" do
    it { source.permalink.should eql("/#{user.username}/#{project.permalink}/sources/#{source.permalink}") }
  end
end
