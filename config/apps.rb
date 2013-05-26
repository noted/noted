Padrino.configure_apps do
  enable :sessions

  set :session_secret, '41262d5faab4a4da87ee69edc104b60bdc288fcf5c420f4508f9a2eb19523c97'
end

Padrino.mount('Noted::Web', :app_file => Padrino.root('app/app.rb')).to('/')
Padrino.mount('Noted::API', :app_file => Padrino.root('api/app.rb')).to('/api')
Padrino.mount('Noted::Admin', :app_file => Padrino.root('admin/app.rb')).to('/admin')
