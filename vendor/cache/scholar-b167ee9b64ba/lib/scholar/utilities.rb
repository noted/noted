module Scholar

  # Manifest various utilities to change attributes correctly.
  class Utilities
    Dir[File.dirname(__FILE__) + '/utilities/*.rb'].each {|file| require file }

    extend Scholar::Utilities::Formatters
    extend Scholar::Utilities::Data
  end
end
