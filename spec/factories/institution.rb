FactoryGirl.define do
	factory(:institution) do
		name "Hyden Planetarium"

		user {|user| user.association(:user)}
	end
end