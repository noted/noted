MongoMapper.connection = Mongo::Connection.new('localhost', nil, :logger => logger)

case Padrino.env
  when :development then MongoMapper.database = 'noted_development'
  when :production  then MongoMapper.database = 'noted_production'
  when :test        then MongoMapper.database = 'noted_test'
end
