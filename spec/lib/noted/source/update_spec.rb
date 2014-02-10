require 'spec_helper'

describe SourceUpdate do
  let(:source) { create :source }
  let(:user)   { source.project.user }
  let(:action) do
    SourceUpdate.run({
      current_user: user,
      source: {
        id: source.id.to_s,
        information: {
          author: [
            {
              given: 'Douglas',
              family: 'Adams'
            }
          ],
          title: 'The Hitchhiker\'s Guide to the Galaxy',
          type: 'book',
          issued: {
            'date-parts' => [ [ 1979 ] ]
          },
          publisher: 'Pan Books',
          'publisher-place' => 'London'
        }
      }
    })
  end

  it { expect(action.success?).to eql true }
  it { expect(action.result).to be_an_instance_of Source }
  it { expect(action.result.information).to_not eql nil }
  it { expect(action.result.citation).to_not eql nil }
end
