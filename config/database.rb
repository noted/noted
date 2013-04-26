require 'yaml'

MongoMapper.setup(YAML.load_file(Padrino.root('.mongo.yml')), PADRINO_ENV, :logger => logger)

Von.configure do |c|
  y = YAML.load_file(Padrino.root('.redis.yml'))
  y = y[PADRINO_ENV]

  c.redis = { :host => y[:host], :port => y[:port], :db => y[:db] }

  c.namespace = 'von'
end
