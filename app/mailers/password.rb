Noted::Web.mailer :password do
  email :reset do |user|
    user = user[:user]

    from 'hello@getnotedapp.com'
    to user.email
    subject 'Noted: Password recovery request'
    locals  :user => user
    content_type 'text/html'
    via :smtp
    render 'password/reset'
  end
end
