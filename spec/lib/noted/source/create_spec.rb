require 'spec_helper'

describe SourceCreate do
  let(:project) { create :project }
  let(:user)    { project.owner }
  let(:action) do
    SourceCreate.run({
      current_user: user,
      project: project,
      source: {
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
  it { expect(action.result.creator).to eql user }
  it { expect(action.result.updater).to eql user }
end
