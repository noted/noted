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
    c.redis = { :host => 'localhost', :port => 6379 }
  end
  c.namespace = 'von'
end
