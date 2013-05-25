# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "sentry-raven"
  s.version = "0.4.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Noah Kantrowitz", "David Cramer"]
  s.date = "2013-05-14"
  s.email = "noah@coderanger.net"
  s.executables = ["raven"]
  s.extra_rdoc_files = ["README.md", "LICENSE"]
  s.files = ["bin/raven", "README.md", "LICENSE"]
  s.homepage = "http://github.com/getsentry/raven-ruby"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.0"
  s.summary = "A gem that provides a client interface for the Sentry error logger"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<faraday>, [">= 0.7.6"])
      s.add_runtime_dependency(%q<uuidtools>, [">= 0"])
      s.add_runtime_dependency(%q<multi_json>, ["~> 1.0"])
      s.add_runtime_dependency(%q<hashie>, [">= 1.1.0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.10"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
      s.add_development_dependency(%q<coveralls>, [">= 0"])
    else
      s.add_dependency(%q<faraday>, [">= 0.7.6"])
      s.add_dependency(%q<uuidtools>, [">= 0"])
      s.add_dependency(%q<multi_json>, ["~> 1.0"])
      s.add_dependency(%q<hashie>, [">= 1.1.0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.10"])
      s.add_dependency(%q<simplecov>, [">= 0"])
      s.add_dependency(%q<coveralls>, [">= 0"])
    end
  else
    s.add_dependency(%q<faraday>, [">= 0.7.6"])
    s.add_dependency(%q<uuidtools>, [">= 0"])
    s.add_dependency(%q<multi_json>, ["~> 1.0"])
    s.add_dependency(%q<hashie>, [">= 1.1.0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.10"])
    s.add_dependency(%q<simplecov>, [">= 0"])
    s.add_dependency(%q<coveralls>, [">= 0"])
  end
end
