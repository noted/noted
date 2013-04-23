FactoryGirl.define do
  factory(:comment) do
    body 'Foo to the bar to the foo.'

    user { |user| user.association(:user) }
  end
end
