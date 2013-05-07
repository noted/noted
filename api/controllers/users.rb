Noted::API.controllers :users do
  get :search, :map => '/users/search/:q', :provides => :json do
    users = User.collection.find(:username => Regexp.new(params[:q])).to_a

    arr = []
    users.each do |u|
      arr << { :value => u['_id'], :name => u['username'] }
    end

    arr.to_json
  end
end
