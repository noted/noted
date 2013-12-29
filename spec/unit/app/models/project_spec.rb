require 'spec_helper'

describe Project do
  let(:project) { create :project }

  it { expect(project).to be_valid }

  it { expect(project).to validate_presence_of :title }

  describe '#permalink!' do
    it { expect(project.permalink).to include 'the-cosmos' }
  end
end
