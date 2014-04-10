module Finders  
  def view_user
    @view_user = User.where(username: params[:user]).first
    @view_user
  end

  def view_project
    if view_user.nil?
      @view_project = nil
    else
      @view_project = Project.where(owner_id: view_user.id, permalink: params[:project]).first
    end

    @view_project
  end

  def view_note
    @view_note = Note.find(params[:note])
    @view_note
  end

  def view_user?
    if view_user.nil?
      not_found
    end
  end

  def view_project?
    if view_project.nil?
      not_found
    end
  end

  def view_note?
    if view_note.nil?
      not_found
    end
  end
end
