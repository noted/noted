require 'spec_helper'

describe Source::Update do
  let(:project) { create(:project) }
  let(:user)    { project.user }

  let(:old) do
    attrs = {
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

    Source::Create.run({
      :author => user.id,
      :project => project.id,
      :attributes => attributes
    })
  end

  let(:citation) do
    "Green, John. <em>Looking for Alaska</em>. New York: Penguin, 2002. Print."
  end

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
      :source => old.result.id,
      :author => user.id,
      :attributes => attributes
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
  it { source.result.citation.html.should eql citation }
end
