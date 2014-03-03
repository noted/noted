RailsAdmin.config do |config|

  ### Popular gems integration

  # == Devise ==
  config.authenticate_with do
    if current_user
      redirect_to '/' unless current_user.admin == true
    else
      redirect_to '/login'
    end
  end

  config.current_user_method { current_user }


  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

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

    ## With an audit adapter, you can add:
    # history_index
    # history_show
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
