Noted::API.controllers :notes, :provides => :json do
  patch :update do
    n = Note::Update.run({
      :author => params[:author],
      :note => params[:note]
    })

    if n.success?
      {
        :status => 200,
        :result => {
          :note => {
            :id => n.result.id.to_s,
            :title => n.result.title,
            :body => n.result.body,
            :tags => n.result.tags_str,
            :sources => n.result.sources
          }
        }
      }.to_json
    else
      d { n.errors }

      halt 400

      {
        :status => 400,
        :errors => n.errors
      }.to_json
    end
  end
end
