FactoryGirl.define do
  sequence :email do |n|
    "neiltyson#{n}@gmail.com"
  end

  sequence :username do |n|
    "neiltyson#{n}"
  end

  factory :user do
    name 'Neil deGrasse Tyson'
    password 'foobar123'

    username
    email
  end
end
