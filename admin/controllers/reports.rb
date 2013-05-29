Noted::Admin.controllers :reports do
  get :index, :cache => true do
    expires_in 30

    @counts = {
      :user => User.count,
      :project => Project.count,
      :note => Note.count,
      :source => Source.count,
      :activity => Activity.count,
      :comment => Comment.count,
      :tag => Tag.count
    }

    render 'reports/index'
  end
end
