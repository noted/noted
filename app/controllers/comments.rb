Noted.controllers :comments do
  post :create do
    comment = Comment::Create.run({
      :author => params[:author],
      :comment => params[:comment]
    })

    if comment.success?
      redirect params[:redirect]
    else

    end
  end

  delete :destroy do
  end
end
