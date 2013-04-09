Noted.controllers :notes do
  before do
    if params[:user] && params[:project]
      @user = User.find_by_username(params[:user])
      @project = Project.where(:user_id => @user.id, :permalink => params[:project]).first
    end
  end

  get :new do
    n = Note::Create.run({
      :project => params[:project],
      :author => params[:author],
    })

    if n.success?
      redirect n.result.url
    else
      flash[:error] = n.errors.message_list
      redirect Project.find(params[:project]).url
    end
  end

  post :create do
    n = Note::Create.run({
      :project => params[:project],
      :author => params[:author],
    })

    if n.success?
      redirect n.result.url
    else
      flash[:error] = n.errors.message_list
      redirect Project.find(params[:project]).url
    end
  end

  get :view, :map => "/:user/:project/notes/:note" do
    @note = Note.where(:project_id => @project.id, :permalink => params[:note]).first

    @sources = [] # Fix me.
    Source.where(:project_id => @project.id).each do |s|
      hash = {}
      hash[:id] = s.id.to_s
      hash[:text] = s.citation.html
      hash[:selected] = @note.sources.include?(s)

      @sources << hash
    end

    render 'notes/view'
  end

  patch :update do
    if params[:note][:source_ids].nil? # Fix me.
      params[:note][:source_ids] = []
    end

    n = Note::Update.run({
      :author => params[:author],
      :note => params[:note]
    })

    if n.success?
      redirect n.result.project.url
    else
      flash[:error] = n.errors.message_list.to_s
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
      redirect project.url
    else
      flash[:error] = n.errors.message_list
      redirect project.url
    end
  end
end
