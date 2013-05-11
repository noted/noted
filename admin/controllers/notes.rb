Noted::Admin.controllers :notes do
  get :view, :with => :id do
    @note = Note.find(params[:id])

    render 'notes/view'
  end
end
