Noted::API.controllers :users do
  get :search, :map => '/users/search', :provides => :json do
    query = params[:query]

    users = User.collection.find(:username => Regexp.new(query)).to_a

    hsh = {}

    hsh[:query] = query

    hsh[:suggestions] = []
    users.each do |u|
      hsh[:suggestions] << { :value => u['username'], :data => u['_id'] }
    end

    hsh.to_json
  end
end
