Noted::Web.controllers :activity do
  before do
    current_project
  end

  get :index, :map => '/:user/:project/activity' do
    @activities = Activity.within(@project.id)

    render 'projects/activity/index'
  end

  get :view, :map => '/:user/:project/activity/:activity' do
    @activity = Activity.where(:permalink => params[:activity]).first

    if @activity
      render 'projects/activity/view'
    else
      halt 404
    end
  end
end
