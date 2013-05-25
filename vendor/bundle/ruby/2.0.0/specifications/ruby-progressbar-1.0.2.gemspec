# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "ruby-progressbar"
  s.version = "1.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["thekompanee", "jfelchner"]
  s.date = "2012-10-07"
  s.description = "Ruby/ProgressBar is an extremely flexible text progress bar library for Ruby.\nThe output can be customized with a flexible formatting system including:\npercentage, bars of various formats, elapsed time and estimated time remaining.\n"
  s.email = "support@thekompanee.com"
  s.extra_rdoc_files = ["README.md", "LICENSE"]
  s.files = ["README.md", "LICENSE"]
  s.homepage = "https://github.com/jfelchner/ruby-progressbar"
  s.rdoc_options = ["--charset = UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "ruby-progressbar"
  s.rubygems_version = "2.0.0"
  s.summary = "Ruby/ProgressBar is a flexible text progress bar library for Ruby."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["~> 2.11"])
      s.add_development_dependency(%q<timecop>, ["~> 0.5"])
      s.add_development_dependency(%q<simplecov>, ["~> 0.5"])
      s.add_development_dependency(%q<guard>, ["~> 1.4"])
      s.add_development_dependency(%q<guard-rspec>, ["~> 2.1"])
      s.add_development_dependency(%q<rb-fsevent>, ["~> 0.9"])
    else
      s.add_dependency(%q<rspec>, ["~> 2.11"])
      s.add_dependency(%q<timecop>, ["~> 0.5"])
      s.add_dependency(%q<simplecov>, ["~> 0.5"])
      s.add_dependency(%q<guard>, ["~> 1.4"])
      s.add_dependency(%q<guard-rspec>, ["~> 2.1"])
      s.add_dependency(%q<rb-fsevent>, ["~> 0.9"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 2.11"])
    s.add_dependency(%q<timecop>, ["~> 0.5"])
    s.add_dependency(%q<simplecov>, ["~> 0.5"])
    s.add_dependency(%q<guard>, ["~> 1.4"])
    s.add_dependency(%q<guard-rspec>, ["~> 2.1"])
    s.add_dependency(%q<rb-fsevent>, ["~> 0.9"])
  end
end
