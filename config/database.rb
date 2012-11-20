require 'yaml'

if heroku?
  m = URI.parse(ENV['MONGOLAB_URI'])

  MongoMapper.connection = Mongo::Connection.new(m.host, m.port, :logger => logger)
  MongoMapper.database = m.path.gsub(/^\//, '')
  MongoMapper.database.authenticate(m.user, m.password)
else
  MongoMapper.setup(YAML.load_file(Padrino.root(".mongo.yml")), PADRINO_ENV, :logger => logger)
end
