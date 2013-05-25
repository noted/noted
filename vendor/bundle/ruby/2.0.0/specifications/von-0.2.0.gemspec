# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "von"
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["blahed"]
  s.date = "2013-02-02"
  s.description = "Von is an opinionated Redis stats tracker."
  s.email = ["tdunn13@gmail.com"]
  s.homepage = ""
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.0"
  s.summary = "Von is an opinionated Redis stats tracker."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<redis>, ["~> 3.0.2"])
      s.add_runtime_dependency(%q<activesupport>, ["~> 3.2.11"])
      s.add_development_dependency(%q<rake>, ["~> 10.0.3"])
      s.add_development_dependency(%q<minitest>, ["~> 3.0.0"])
      s.add_development_dependency(%q<fakeredis>, ["~> 0.4.1"])
      s.add_development_dependency(%q<mocha>, ["~> 0.11.4"])
      s.add_development_dependency(%q<timecop>, ["~> 0.5.9.1"])
    else
      s.add_dependency(%q<redis>, ["~> 3.0.2"])
      s.add_dependency(%q<activesupport>, ["~> 3.2.11"])
      s.add_dependency(%q<rake>, ["~> 10.0.3"])
      s.add_dependency(%q<minitest>, ["~> 3.0.0"])
      s.add_dependency(%q<fakeredis>, ["~> 0.4.1"])
      s.add_dependency(%q<mocha>, ["~> 0.11.4"])
      s.add_dependency(%q<timecop>, ["~> 0.5.9.1"])
    end
  else
    s.add_dependency(%q<redis>, ["~> 3.0.2"])
    s.add_dependency(%q<activesupport>, ["~> 3.2.11"])
    s.add_dependency(%q<rake>, ["~> 10.0.3"])
    s.add_dependency(%q<minitest>, ["~> 3.0.0"])
    s.add_dependency(%q<fakeredis>, ["~> 0.4.1"])
    s.add_dependency(%q<mocha>, ["~> 0.11.4"])
    s.add_dependency(%q<timecop>, ["~> 0.5.9.1"])
  end
end
