FactoryGirl.define do
  factory(:project) do
    title "The Cosmos"
    description "Exploring the cosmos, one star system at a time."

    user {|user| user.association(:user)}

    creator {|user| user.association(:user)}

    after(:create) do |project, evalulator|
      project.user.projects << project
    end
  end
end
