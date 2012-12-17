Noted.helpers do
  def current_state
    @state = Hash.new

    if params[:user]
      @state[:user] = User.find_by_username(params[:user])
    end

    if params[:project]
      @state[:project] = Project.find_by_permalink(params[:project])
    end

    if params[:source]
      @state[:source] = Source.find_by_permalink(params[:source])
    end
  end
end