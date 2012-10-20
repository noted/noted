FactoryGirl.define do
	sequence :email do |n|
    "neil#{n}@hyden.org"
  end

	factory(:user) do
		name "Neil deGrasse Tyson"
		username "neiltyson"
		password "foobar"
		email
	end
end