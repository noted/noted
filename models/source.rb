class Source
  include MongoMapper::Document
  
  timestamps!
  userstamps!

  belongs_to :project

  many :comments, :as => :commentable

  many :contributors
  one :annotation
end

class Book < Source
  key :title, String
  key :city, String
  key :publisher, String
  key :year, Date
  key :page_numbers, Boolean
  key :scholarly_edition, Boolean
  key :edition, String
  key :number_volumes, Integer
  key :volume, Integer
  key :title_multivolume, String
  key :series_name, String
  key :series_number, String
  key :original_year, Date
end

class Contributor
  include MongoMapper::EmbeddedDocument

  key :first, String
  key :middle, String
  key :last, String
  key :suffix, String
  key :role, String

  embedded_in :source
end

class Annotation
  include MongoMapper::EmbeddedDocument

  key :text, String
end

# Completely incomplete.
