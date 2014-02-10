require 'spec_helper'

describe SourceDestroy do
  let(:source) { create :source }
  let(:user)   { source.project.user }
  let(:action) do
    SourceDestroy.run({
      current_user: user,
      source: {
        id: source.id.to_s
      }
    })
  end

  it { expect(action.success?).to eql true }
  it { expect(action.result).to eql nil }
end
