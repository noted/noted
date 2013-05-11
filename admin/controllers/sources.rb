Noted::Admin.controllers :sources do
  get :view, :with => :id do
    @source = Source.find(params[:id])

    render 'sources/view'
  end
end
