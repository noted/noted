# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "padrino-sprockets"
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Night Sailer, Matthias G\u{fc}nther"]
  s.date = "2013-05-25"
  s.description = "Padrino with Sprockets"
  s.email = ["nightsailer@gmail.com, matthias.guenther@wikimatze.de"]
  s.files = ["lib/padrino/sprockets-version.rb", "lib/padrino/sprockets.rb"]
  s.homepage = "https://github.com/nightsailer/padrino-sprockets"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.0"
  s.summary = "Padrino with Sprockets"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sprockets>, [">= 0"])
    else
      s.add_dependency(%q<sprockets>, [">= 0"])
    end
  else
    s.add_dependency(%q<sprockets>, [">= 0"])
  end
end
