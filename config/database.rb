require 'yaml'

if ENV['MONGOLAB_URI']
  m = URI.parse(ENV['MONGOLAB_URI'])

  MongoMapper.connection = Mongo::Connection.new(m.host, m.port, :logger => logger)
  MongoMapper.database = m.path.gsub(/^\//, '')
  MongoMapper.database.authenticate(m.user, m.password)
else
  MongoMapper.setup(YAML.load_file(Padrino.root(".mongo.yml")), PADRINO_ENV, :logger => logger)
end

Von.configure do |c|
  if ENV['REDISTOGO_URL']
    r = URI.parse(ENV['REDISTOGO_URL'])

    c.redis = { :host => r.host, :port => r.port, :password => r.password }
  else
    y = YAML.load_file(Padrino.root(".redis.yml"))
    y = y[PADRINO_ENV]

    c.redis = { :host => y["host"], :port => y["port"], :db => y["db"] }
  end

  c.namespace = 'von'
end
