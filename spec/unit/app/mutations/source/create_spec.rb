require 'spec_helper'

describe Source::Create do
  let(:project) { create(:project) }
  let(:user)    { project.user }

  let(:attributes) do
    {
      :type => :book,
      :title => "The Fault in Our Stars",
      :contributors => [
        {
          :role => :author,
          :first => "John",
          :last => "Green"
        }
      ],
      :publisher => "Penguin",
      :city => "New York",
      :year => "2012",
      :media => :print
    }
  end

  let(:source) do
    Source::Create.run({
      :author => user.id,
      :project => project.id,
      :source => {
        :attributes => attributes
      }
    })
  end

  before do
    user.reload
    project.reload
  end

  it { source.success?.should be_true }
  it { source.result.should be_an_instance_of Source }
  it { source.result.creator.should eql user }
  it { source.result.project.should eql project }
  it { source.result.citation.should be_an_instance_of Scholar::Citation }
  it { source.result.citation.html.should eql "Green, John. <em>The Fault in Our Stars</em>. New York: Penguin, 2012. Print." }
end
