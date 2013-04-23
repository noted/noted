FactoryGirl.define do
  sequence :email do |n|
    "neil#{n}@hyden.org"
  end

  sequence :username do |n|
    "neiltyson#{n}"
  end

  factory(:user) do
    name 'Neil deGrasse Tyson'
    password 'foobar'
    username
    email

    trait(:staff) do
      name 'Les Grossman'
      username 'les'
      password 'barfoo'
      email

      after(:create) do |user, evaluator|
        user.hire!
      end
    end
  end
end
