require 'spec_helper'

describe Activity do
  let(:activity) { create(:activity) }

  it { should validate_presence_of :actor }
  it { should validate_presence_of :action }
  it { should validate_presence_of :recipient }

  it { activity.should be_valid }
end
