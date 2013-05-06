FactoryGirl.define do
  factory(:activity) do
    actor     { |user| user.association(:user) }
    recipient { |note| note.association(:note) }
    action    'create'
  end
end
