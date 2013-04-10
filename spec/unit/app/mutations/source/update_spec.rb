require 'spec_helper'

describe Source::Update do
  let(:old)     { create(:source) }
  let(:project) { old.project }
  let(:user)    { project.user }

  let(:attributes) do
    {
      "type" => "book",
      "contributors" => {
        "0" => {
          "role" => "author",
          "first" => "Neil",
          "middle"=> "",
          "last" => "deGrasse Tyson",
          "suffix" => ""
        }
      },
      "title" => "The Space Chronicles",
      "publisher" => "W. W. Norton & Company",
      "city" => "New York",
      "year" => "2012",
      "volume" => "",
      "edition" => "",
      "series" => ""
    }
  end

  let(:source) do
    Source::Update.run({
      :author => user.id.to_s,
      :source => {
        :id => old.id.to_s,
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
  it { source.result.citation.html.should eql "deGrasse Tyson, Neil. <em>The Space Chronicles</em>. New York: W. W. Norton & Company, 2012." }
end
