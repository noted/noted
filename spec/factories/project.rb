FactoryGirl.define do
  factory :project do
    title 'The Cosmos'
    permalink 'the-cosmos'

    owner { create(:user) }

    before(:create) do |project, evaluator|
      project.users << project.owner
      project.users << create(:user)
    end
  end
end
