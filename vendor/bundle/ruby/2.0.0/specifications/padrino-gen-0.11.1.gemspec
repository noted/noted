# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "padrino-gen"
  s.version = "0.11.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.authors = ["Padrino Team", "Nathan Esquenazi", "Davide D'Agostino", "Arthur Chiu"]
  s.date = "2013-04-07"
  s.description = "Generators for easily creating and building padrino applications from the console"
  s.email = "padrinorb@gmail.com"
  s.executables = ["padrino-gen"]
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["bin/padrino-gen", "README.rdoc"]
  s.homepage = "http://www.padrinorb.com"
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "padrino-gen"
  s.rubygems_version = "2.0.0"
  s.summary = "Generators for easily creating and building padrino applications"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<padrino-core>, ["= 0.11.1"])
      s.add_runtime_dependency(%q<bundler>, ["~> 1.0"])
    else
      s.add_dependency(%q<padrino-core>, ["= 0.11.1"])
      s.add_dependency(%q<bundler>, ["~> 1.0"])
    end
  else
    s.add_dependency(%q<padrino-core>, ["= 0.11.1"])
    s.add_dependency(%q<bundler>, ["~> 1.0"])
  end
end
