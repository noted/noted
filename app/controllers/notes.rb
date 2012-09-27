Noted.controllers :notes do
  get :index, :map => "/:user/:project/notes" do
  end

  post :create do
  end

  get :view, :map => "/:user/:project/notes/:note" do
  end

  put :modify do
  end

  delete :destroy do
  end
end