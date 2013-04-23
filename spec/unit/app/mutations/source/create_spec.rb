require 'spec_helper'

describe Source::Create do
  let(:project) { create(:project) }
  let(:user)    { project.user }

  let(:attributes) do
    {
      'type' => 'book',
      'contributors' => {
        '0' => {
          'role' => 'author',
          'first' => 'J',
          'middle' => 'K',
          'last' => 'Rowling',
          'suffix' => ''
        }
      },
      'title' => 'Harry Potter and the Deathly Hallows',
      'publisher' => 'Scholastic',
      'city' => 'New York',
      'year' => '2008',
      'volume' => '',
      'edition' => '',
      'series' => ''
    }
  end

  let(:source) do
    Source::Create.run({
      :author => user.id.to_s,
      :project => project.id.to_s,
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
  it { source.result.citation.html.should eql 'Rowling, J. K. <em>Harry Potter and the Deathly Hallows</em>. New York: Scholastic, 2008.' }
end
