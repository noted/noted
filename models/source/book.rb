class Book < Source
  key :title, String
  
  key :page_numbers, Boolean
  key :scholarly_edition, Boolean
  key :edition, String
  
  key :number_volumes, Integer
  key :volume, Integer
  key :title_multivolume, String
  
  key :series_name, String
  key :series_number, String
  
  key :year, Date

  one :publisher
end