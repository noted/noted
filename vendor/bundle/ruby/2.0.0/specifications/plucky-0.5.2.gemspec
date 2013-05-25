# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "plucky"
  s.version = "0.5.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["John Nunemaker"]
  s.date = "2012-09-12"
  s.email = ["nunemaker@gmail.com"]
  s.homepage = "http://jnunemaker.github.com/plucky/"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.0"
  s.summary = "Thin layer over the ruby driver that allows you to quickly grab hold of your data (pluck it!)."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mongo>, ["~> 1.5"])
    else
      s.add_dependency(%q<mongo>, ["~> 1.5"])
    end
  else
    s.add_dependency(%q<mongo>, ["~> 1.5"])
  end
end
