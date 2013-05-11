Noted::Admin.controllers :sources do
  get :view, :with => :id do
    render 'sources/view'
  end
end
