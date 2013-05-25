Noted::Web.controllers :notes do
  before do
    if params[:user] && params[:project]
      @user = User.find_by_username(params[:user])
      @project = Project.given(@user.id, params[:project]).first

      unless @user && @project
        halt 404
      end
    end
  end

  get :new do
    n = Note::Create.run({
      :project => params[:project],
      :author => params[:author],
    })

    if n.success?
      expire!("#{n.result.project.id}_notes")

      redirect "#{n.result.url}/#edit"
    else
      flash[:error] = 'Something has gone awry.'
      redirect Project.find(params[:project]).url
    end
  end

  post :create do
    n = Note::Create.run({
      :project => params[:project],
      :author => params[:author],
    })

    if n.success?
      expire!("#{n.result.project.id}_notes")

      redirect n.result.url
    else
      flash[:error] = 'Something has gone awry.'
      redirect Project.find(params[:project]).url
    end
  end

  get :view, :map => '/:user/:project/notes/:note' do
    @note = Note.where(
      :project_id => @project.id,
      :permalink => params[:note],
      :deleted_at => nil
    ).first

    if @note
      @sources = [] # Fix me.
      Source.where(:project_id => @project.id).each do |s|
        hash = {}
        hash[:id] = s.id.to_s
        hash[:text] = s.citation.html
        hash[:selected] = @note.sources.include?(s)

        @sources << hash
      end

      render 'notes/view'
    else
      halt 404
    end
  end

  patch :update do
    n = Note::Update.run({
      :author => params[:author],
      :note => params[:note]
    })

    if n.success?
      expire!("#{n.result.project.id}_notes")

      redirect n.result.project.url
    else
      flash[:error] = 'Something has gone awry.'
      redirect Note.find(params[:note][:id]).url
    end
  end

  delete :destroy do
    project = Note.find(params[:note][:id]).project

    n = Note::Destroy.run({
      :author => params[:author],
      :note => params[:note]
    })

    if n.success?
      expire!("#{project.id}_notes")

      redirect project.url
    else
      flash[:error] = 'Something has gone awry.'
      redirect project.url
    end
  end
end
