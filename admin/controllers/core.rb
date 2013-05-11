Noted::Admin.controllers do
  before do
    authorize!
  end

  get :index do
    render 'core/index'
  end
end
