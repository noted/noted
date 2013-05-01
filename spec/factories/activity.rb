FactoryGirl.define do
  factory(:activity, :class => Activity::Create) do
    actor     { |user| user.association(:user).id }
    recipient { |note| note.association(:note).id }
  end
end
