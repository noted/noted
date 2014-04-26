# This file seeds the database with citation styles.

CSL::Style.ls.each do |shortname|
  existing = CitationStyle.where(shortname: shortname).first

  if existing.nil?
    style = CitationStyle.new(
      shortname: shortname
    )

    style.save

    puts "#{shortname} added"
  else
    puts "#{shortname} exists"
  end
end
