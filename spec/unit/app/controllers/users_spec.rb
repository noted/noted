require "spec_helper"

describe "Users" do
	describe "GET /:user" do
		before do
			@u = create(:user)

			get "/#{@u.username}"
		end

		it "should be ok" do
			response.should be_ok
		end
	end
	
	describe "GET /register" do
		before do
			get "/register"
		end

		it "should be ok" do
			response.should be_ok
		end
	end

	describe "POST /users/create" do
		before do
			post "/users/create", :user => { :name => "Buzz Aldrin", :username => "buzz", :email => "buzz@nasa.gov", :password => "foobar" }
		end

		it "should create a User" do
			User.find_by_name("Buzz Aldrin").should_not be_nil
		end

		it "should redirect correctly" do
			response.should be_redirect
			response.location.should == "/"
		end
	end
end