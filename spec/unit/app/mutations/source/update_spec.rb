require 'spec_helper'

describe Source::Update do
  let(:old)     { create(:source) }
  let(:project) { old.project }
  let(:user)    { project.user }

  let(:attributes) do
    {
      :type => :book,
      :title => "Looking for Alaska",
      :contributors => [
        {
          :role => :author,
          :first => "John",
          :last => "Green"
        }
      ],
      :publisher => "Penguin",
      :city => "New York",
      :year => "2002",
      :media => :print
    }
  end

  let(:source) do
    Source::Update.run({
      :author => user.id,
      :source => {
        :id => old.id,
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
  it { source.result.updater.should eql user }
  it { source.result.project.should eql project }
  it { source.result.citation.should be_an_instance_of Scholar::Citation }
  it { source.result.citation.html.should eql "Green, John. <em>Looking for Alaska</em>. New York: Penguin, 2002. Print." }
end
