# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "scholar"
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ethan Turkeltaub"]
  s.date = "2013-05-25"
  s.description = "Generate valid MLA citations."
  s.email = ["ethan.turkeltaub@gmail.com"]
  s.files = [".gitignore", ".rspec", ".ruby-version", ".travis.yml", "Gemfile", "Gemfile.lock", "LICENSE.md", "README.md", "Rakefile", "lib/scholar.rb", "lib/scholar/citation.rb", "lib/scholar/search.rb", "lib/scholar/source.rb", "lib/scholar/sources/book.rb", "lib/scholar/utilities.rb", "lib/scholar/utilities/contributor.rb", "lib/scholar/utilities/contributor_list.rb", "lib/scholar/utilities/data.rb", "lib/scholar/utilities/formatters.rb", "scholar.gemspec", "spec/factories/contributor.rb", "spec/factories/contributor_list.rb", "spec/scholar/citation_spec.rb", "spec/scholar/search_spec.rb", "spec/scholar/source_spec.rb", "spec/scholar/sources/book_spec.rb", "spec/scholar/utilities/contributor_list_spec.rb", "spec/scholar/utilities/contributor_spec.rb", "spec/scholar/utilities/data_spec.rb", "spec/scholar/utilities/formatters_spec.rb", "spec/spec_helper.rb"]
  s.homepage = "http://github.com/noted/scholar"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.0"
  s.summary = "Generate valid MLA citations."
  s.test_files = ["spec/factories/contributor.rb", "spec/factories/contributor_list.rb", "spec/scholar/citation_spec.rb", "spec/scholar/search_spec.rb", "spec/scholar/source_spec.rb", "spec/scholar/sources/book_spec.rb", "spec/scholar/utilities/contributor_list_spec.rb", "spec/scholar/utilities/contributor_spec.rb", "spec/scholar/utilities/data_spec.rb", "spec/scholar/utilities/formatters_spec.rb", "spec/spec_helper.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, ["~> 3.2.11"])
      s.add_runtime_dependency(%q<faraday>, ["~> 0.8.7"])
      s.add_runtime_dependency(%q<faraday_middleware>, ["~> 0.9.0"])
    else
      s.add_dependency(%q<activesupport>, ["~> 3.2.11"])
      s.add_dependency(%q<faraday>, ["~> 0.8.7"])
      s.add_dependency(%q<faraday_middleware>, ["~> 0.9.0"])
    end
  else
    s.add_dependency(%q<activesupport>, ["~> 3.2.11"])
    s.add_dependency(%q<faraday>, ["~> 0.8.7"])
    s.add_dependency(%q<faraday_middleware>, ["~> 0.9.0"])
  end
end
