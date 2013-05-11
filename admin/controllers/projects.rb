Noted::Admin.controllers :projects do
  get :view, :with => :id do
    @project = Project.find(params[:id])

    render 'projects/view'
  end
end
