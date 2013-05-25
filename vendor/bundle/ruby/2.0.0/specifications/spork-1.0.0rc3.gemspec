# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "spork"
  s.version = "1.0.0rc3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tim Harper", "Donald Parish"]
  s.date = "2012-05-04"
  s.description = "A forking Drb spec server"
  s.email = ["timcharper+spork@gmail.com"]
  s.executables = ["spork"]
  s.extra_rdoc_files = ["MIT-LICENSE", "README.rdoc"]
  s.files = ["bin/spork", "MIT-LICENSE", "README.rdoc"]
  s.homepage = "http://github.com/sporkrb/spork"
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.0"
  s.summary = "spork"
end
