Noted::API.controllers :users do
  get :search, :map => '/users/search', :provides => :json do
    query = params[:term]

    users = User.collection.find(:username => Regexp.new(query)).to_a

    hsh = Hash.new

    hsh[:query] = query

    hsh[:suggestions] = []
    users.each do |u|
      hsh[:suggestions] << { :value => u['username'], :data => u['_id'] }
    end

    d { params }

    hsh.to_json
  end

  get :search2, :map => '/users/search2', :provides => :json do
    users = User.collection.find(:username => Regexp.new(params[:q])).to_a

    arr = []
    users.each do |u|
      arr << { :value => u['_id'], :name => u['username'] }
    end

    arr.to_json
  end

  get :search3, :map => '/users/search3', :provides => :json do
    users = User.collection.find(:username => Regexp.new(params[:term])).to_a

    arr = []
    users.each do |u|
      arr << u['username']
    end

    arr.to_json
  end
end
