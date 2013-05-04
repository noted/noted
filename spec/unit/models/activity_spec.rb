require 'spec_helper'

describe Activity do
  let(:user) { create(:user) }
  let(:note) { create(:note) }

  let(:activity) do
    Activity.create(
      :actor => user,
      :recipient => note,
      :recipient_parent => note.project,
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

    context 'set with ID' do
      before do
        activity.actor = two.id.to_s
      end

      it { activity.actor_id.should eql two.id }
      it { activity.actor.should eql two }
    end

    context 'set with User' do
      before do
        activity.actor = two
      end

      it { activity.actor_id.should eql two.id }
      it { activity.actor.should eql two }
    end
  end

  describe '#by' do
    let(:query) { Activity.by(activity.actor_id) }

    it { query.should be_an_instance_of Plucky::Query }
    it { query.all.should include activity }
  end

  describe '#for' do
    let(:query) { Activity.for(activity.recipient_id) }

    it { query.should be_an_instance_of Plucky::Query }
    it { query.all.should include activity }
  end

  describe '#within' do
    let(:query) { Activity.within(activity.recipient_parent_id) }

    it { query.should be_an_instance_of Plucky::Query }
    it { query.all.should include Activity }
    it { query.all.size.should be > 1 }
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

  describe '#recipient_parent' do
    let(:two) { create(:project) }

    before do
      activity.recipient_parent = two
    end

    it { activity.recipient_parent_class.should eql 'Project' }
    it { activity.recipient_parent_id.should eql two.id }
    it { activity.recipient_parent.should eql two }
  end
end
