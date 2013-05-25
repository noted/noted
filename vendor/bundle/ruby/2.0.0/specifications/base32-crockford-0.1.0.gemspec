# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "base32-crockford"
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Levin Alexander"]
  s.date = "2011-06-24"
  s.email = "mail@levinalex.net"
  s.homepage = "http://levinalex.net/src/base32"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.0"
  s.summary = "32-symbol notation for expressing numbers in a form that can be conveniently and accurately transmitted between humans"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
