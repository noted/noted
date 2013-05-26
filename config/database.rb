require 'yaml'

# MongoMapper
MongoMapper.setup(YAML.load_file(Padrino.root('.mongo.yml')), PADRINO_ENV, :logger => nil)
MongoMapper::Document.plugin(MongoMapper::Plugins::IdentityMap)

# Von
Von.configure do |c|
  y = YAML.load_file(Padrino.root('.redis.yml'))
  y = y[PADRINO_ENV]

  c.redis = { :host => y[:host], :port => y[:port], :db => y[:db] }

  c.namespace = 'von'
end

# Load configurations
unless PADRINO_ENV == 'test'
  SMTP = YAML.load_file(Padrino.root('.smtp.yml'))[PADRINO_ENV]
  SENTRY = YAML.load_file(Padrino.root('.sentry.yml'))
end
