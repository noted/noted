# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "mm-paranoid"
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Richard Livsey"]
  s.date = "2011-03-09"
  s.email = "richard@livsey.org"
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["LICENSE", "Rakefile", "README.rdoc", "spec", "lib/mm-paranoid.rb"]
  s.homepage = "http://github.com/rlivsey/mm-paranoid"
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.0"
  s.summary = "Tiny plugin for MongoMapper to set deleted_at instead of actually deleting the record."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mongo_mapper>, [">= 0.9.0"])
    else
      s.add_dependency(%q<mongo_mapper>, [">= 0.9.0"])
    end
  else
    s.add_dependency(%q<mongo_mapper>, [">= 0.9.0"])
  end
end
