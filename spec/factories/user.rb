FactoryGirl.define do
  sequence :email do |n|
    "neil#{n}@hyden.org"
  end

  factory(:user) do
    name "Neil deGrasse Tyson"
    username "neiltyson"
    password "foobar"
    email

    factory(:staff) do
      name "Les Grossman"
      username "les"
      password "barfoo"
      email

      after(:create) do |user, evaluator|
        user.hire!
      end
    end
  end
end