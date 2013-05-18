Noted::Web.mailer :password do
  email :reset do |user|
    from 'hello@getnotedapp.com'
    to user.email
    subject 'Noted: Password recovery request'
    locals  :user => user
    content_type 'text/html'
    via :smtp
    render 'users/forgot'
  end
end
