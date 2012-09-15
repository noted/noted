Padrino.configure_apps do
  set :session_secret, '41262d5faab4a4da87ee69edc104b60bdc288fcf5c420f4508f9a2eb19523c97'
end

Padrino.mount("Noted").to('/')
