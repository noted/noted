# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "mutations"
  s.version = "0.5.12"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jonathan Novak"]
  s.date = "2013-03-09"
  s.description = "Compose your business logic into commands that sanitize and validate input."
  s.email = "jnovak@gmail.com"
  s.homepage = "http://github.com/cypriss/mutations"
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.2")
  s.rubygems_version = "2.0.0"
  s.summary = "Compose your business logic into commands that sanitize and validate input."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 0"])
      s.add_development_dependency(%q<minitest>, ["~> 4"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<activesupport>, [">= 0"])
      s.add_dependency(%q<minitest>, ["~> 4"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 0"])
    s.add_dependency(%q<minitest>, ["~> 4"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
