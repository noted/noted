RailsAdmin.config do |config|
  config.authenticate_with do
    if current_user
      redirect_to '/' unless current_user.admin == true
    else
      redirect_to '/login'
    end
  end

  config.current_user_method { current_user }

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
  end

  config.model 'Project' do
    list do
      field :id
      field :title
      field :permalink
      field :users
      field :created_at
      field :updated_at

      field :owner do
        formatted_value do
          User.find(value).name
        end

        pretty_value do
          User.find(value).name
        end
      end
    end
  end
end
