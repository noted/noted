FactoryGirl.define do
  factory :note do
    title "The Cosmos"
    text "**Hello, world.**"

    user
  end
end