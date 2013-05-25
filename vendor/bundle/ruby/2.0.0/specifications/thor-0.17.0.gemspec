# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "thor"
  s.version = "0.17.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.authors = ["Yehuda Katz", "Jos\u{e9} Valim"]
  s.date = "2013-01-24"
  s.description = "A scripting framework that replaces rake, sake and rubigen"
  s.email = "ruby-thor@googlegroups.com"
  s.executables = ["rake2thor", "thor"]
  s.extra_rdoc_files = ["CHANGELOG.rdoc", "LICENSE.md", "README.md", "Thorfile"]
  s.files = ["bin/rake2thor", "bin/thor", "CHANGELOG.rdoc", "LICENSE.md", "README.md", "Thorfile"]
  s.homepage = "http://whatisthor.com/"
  s.licenses = ["MIT"]
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.0"
  s.summary = "A scripting framework that replaces rake, sake and rubigen"
end
