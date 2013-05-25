# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "mongo_mapper"
  s.version = "0.12.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["John Nunemaker"]
  s.date = "2012-09-12"
  s.email = ["nunemaker@gmail.com"]
  s.executables = ["mmconsole"]
  s.files = ["bin/mmconsole"]
  s.homepage = "http://mongomapper.com"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.0"
  s.summary = "A Ruby Object Mapper for Mongo"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activemodel>, ["~> 3.0"])
      s.add_runtime_dependency(%q<activesupport>, ["~> 3.0"])
      s.add_runtime_dependency(%q<plucky>, ["~> 0.5.2"])
    else
      s.add_dependency(%q<activemodel>, ["~> 3.0"])
      s.add_dependency(%q<activesupport>, ["~> 3.0"])
      s.add_dependency(%q<plucky>, ["~> 0.5.2"])
    end
  else
    s.add_dependency(%q<activemodel>, ["~> 3.0"])
    s.add_dependency(%q<activesupport>, ["~> 3.0"])
    s.add_dependency(%q<plucky>, ["~> 0.5.2"])
  end
end
