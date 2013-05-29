Noted::Admin.controllers do
  before do
    authorize!
  end

  get :index, :cache => true do
    render 'core/index'
  end
end
