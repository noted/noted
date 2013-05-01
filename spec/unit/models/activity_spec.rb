require 'spec_helper'

describe Activity do
  let(:user) { create(:user) }
  let(:note) { create(:note) }

  let(:activity) do
    Activity.new(
      :actor => user,
      :recipient => note,
      :action => 'create'
    )
  end

  it { should validate_presence_of :actor_id }
  it { should validate_presence_of :action }
  it { should validate_presence_of :recipient_class }
  it { should validate_presence_of :recipient_id }

  it { activity.should be_valid }

  describe '#actor' do
    it { activity.actor.should eql user }
  end

  describe '#actor=' do
    let(:two) { create(:user) }

    before do
      activity.actor = two
    end

    it { activity.actor_id.should eql two.id }
    it { activity.actor.should eql two }
  end

  describe '#recipient' do
    it { activity.recipient.should eql note }
  end

  describe '#recipient=' do
    let(:two) { create(:source) }

    before do
      activity.recipient = two
    end

    it { activity.recipient_class.should eql 'Source' }
    it { activity.recipient_id.should eql two.id }
    it { activity.recipient.should eql two }
  end
end
