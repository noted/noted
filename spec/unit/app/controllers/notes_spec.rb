require "spec_helper"

describe "Notes" do
	describe "GET /:user/:project/notes" do
		before do
			@u = create(:user)

			@p = create(:project)
			@u.projects << @p

			@n = create(:note)
			@p.notes << @n

			get "/#{@u.username}/#{@p.permalink}/notes"
		end

		it "should be ok" do
			response.should be_ok
		end
	end
end