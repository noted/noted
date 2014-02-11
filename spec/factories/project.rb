FactoryGirl.define do
  factory :project do
    title 'The Cosmos'

    owner { create(:user) }
  end
end
