Noted::Web.controllers :sources do
  before :except => [:create, :update, :destroy] do
    if params[:user] && params[:project]
      @user = User.find_by_username(params[:user])
      @project = Project.given(@user.id, params[:project]).first
    end
  end

  get :new, :map => '/:user/:project/sources/new' do
    render 'sources/new'
  end

  post :create do # Fix me!
    type = "#{params[:source][:type]}"

    attributes = params[type]
    attributes.merge({:type => type.to_sym})

    s = Source::Create.run({
      :project => params[:project],
      :author => params[:author],
      :source => { :attributes => attributes }
    })

    if s.success?
      expire!("#{s.result.project.id}_sources")

      redirect Project.find(params[:project]).url
    else
      redirect Project.find(params[:project]).url
    end
  end

  patch :update do
    type = "#{params[:source][:type]}"

    attributes = params[type]
    attributes.merge({:type => type.to_sym})

    s = Source::Update.run({
      :author => params[:author],
      :source => {
        :id => params[:source][:id],
        :attributes => attributes
      }
    })

    if s.success?
      expire!("#{s.result.project.id}_sources")

      redirect s.result.project.url
    else
      flash[:error] = 'Something has gone awry.'
      redirect Source.find(params[:source][:id]).url
    end
  end

  delete :destroy do
    project = Source.find(params[:source][:id]).project

    s = Source::Destroy.run({
      :author => params[:author],
      :source => params[:source]
    })

    if s.success?
      expire!("#{project.id}_sources")

      redirect project.url
    else
      flash[:error] = "Something has gone awry."
      redirect project.url
    end
  end

  get :bibliography, :map => '/:user/:project/sources/bibliography', :priority => :high do
    @sources = Source.where(
      :project_id => @project.id,
      :deleted_at => nil
    ).all

    render 'sources/bibliography'
  end

  get :view, :map => '/:user/:project/sources/:source', :priority => :low do
    @source = Source.where(
      :project_id => @project.id,
      :permalink => params[:source],
      :deleted_at => nil
    ).first # Make scope!
    @citation = @source.citation

    render 'sources/view'
  end
end
