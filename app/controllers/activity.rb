Noted::Web.controllers :activity do
  get :index, :map => '/:user/:project/activity' do
    @user = User.find_by_username(params[:user])
    @project = Project.where(
      :user_id => @user.id,
      :permalink => params[:project],
      :deleted_at => nil
    ).first
    @activities = Activity.within(@project.id)

    render 'projects/activity/index'
  end

  get :view, :map => '/:user/:project/activity/:activity' do
    @user = User.find_by_username(params[:user])
    @project = Project.where(
      :user_id => @user.id,
      :permalink => params[:project],
      :deleted_at => nil
    ).first
    @activity = Activity.where(:permalink => params[:activity]).first

    render 'projects/activity/view'
  end
end
