class Publisher
  include MongoMapper::EmbeddedDocument

  key :name, String
  key :city, String
  key :year, String

  embedded_in :source
end
