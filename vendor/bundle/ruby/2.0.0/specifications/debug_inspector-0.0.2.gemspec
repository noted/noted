# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "debug_inspector"
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["John Mair (banisterfiend)"]
  s.date = "2013-02-13"
  s.description = "A Ruby wrapper for the MRI 2.0 debug_inspector API"
  s.email = ["jrmair@gmail.com"]
  s.extensions = ["ext/debug_inspector/extconf.rb"]
  s.files = ["ext/debug_inspector/extconf.rb"]
  s.homepage = "https://github.com/banister/debug_inspector"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.0"
  s.summary = "A Ruby wrapper for the MRI 2.0 debug_inspector API"
end
