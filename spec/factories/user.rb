FactoryGirl.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :user do
    name "Neil deGrasse Tyson"
    username "neiltyson"
    email
    location "The Universe"

    after(:build) { |u| u.password = "foobar" }
  end
end