require 'yaml'

# MongoMapper
MongoMapper.setup(YAML.load_file(Padrino.root('.mongo.yml')), PADRINO_ENV, :logger => nil)
MongoMapper::Document.plugin(MongoMapper::Plugins::IdentityMap)

# Von
Von.configure do |c|
  if PADRINO_ENV == 'production'
    uri = URI.parse(ENV['REDISTOGO_URL'])

    c.redis = { :host => uri.host, :port => uri.port, :password => uri.password }
  else
    y = YAML.load_file(Padrino.root('.redis.yml'))
    y = y[PADRINO_ENV]

    c.redis = { :host => y[:host], :port => y[:port], :db => y[:db] }
  end

  c.namespace = 'von'
end

# Load configurations
unless PADRINO_ENV == 'test'
  SMTP = YAML.load_file(Padrino.root('.smtp.yml'))[PADRINO_ENV]
  SENTRY = YAML.load_file(Padrino.root('.sentry.yml'))
end
