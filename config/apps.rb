Padrino.configure_apps do
  enable :sessions

  set :session_secret, '41262d5faab4a4da87ee69edc104b60bdc288fcf5c420f4508f9a2eb19523c97'

  MongoMapper::Document.plugin(MongoMapper::Plugins::IdentityMap)
  MongoMapper::Document.plugin(MongoMapper::Plugins::Paranoid)
end

Padrino.mount('Noted::Web').to('/')
