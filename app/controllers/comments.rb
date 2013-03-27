Noted.controllers :comments do
  post :create do
    comment = Comment::Create.run({
      :author => params[:author],
      :comment => params[:comment]
    })

    if comment.success?
      redirect params[:redirect]
    else
      flash[:error] = comment.error.message_list
      redirect params[:redirect]
    end
  end

  delete :destroy do
    c = Comment::Destroy.run({
      :comment => params[:comment]
    })

    if c.success?
      redirect params[:redirect]
    else
      flash[:error] = comment.error.message_list
      redirect params[:redirect]
    end
  end
end
