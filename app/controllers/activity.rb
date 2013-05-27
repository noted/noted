Noted::Web.controllers :activity do
  before do
    if params[:user] && params[:project]
      @user = User.find_by_username(params[:user])
      @project = Project.where(
        :user_id => @user.id,
        :permalink => params[:project],
        :deleted_at => nil
      ).first

      unless @user && @project
        halt 404
      end
    end
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
