# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "cijoe"
  s.version = "0.9.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Chris Wanstrath", "Josh Owens"]
  s.date = "2013-05-25"
  s.description = "  cijoe is a sinatra-based continuous integration server. It's like an\n  old rusty pickup truck: it might be smelly and gross, but it gets the\n  job done.\n"
  s.email = "chris@ozmm.org"
  s.executables = ["cijoe"]
  s.files = ["README.md", "Rakefile", "LICENSE", "lib/cijoe", "lib/cijoe/build.rb", "lib/cijoe/campfire.rb", "lib/cijoe/commit.rb", "lib/cijoe/config.rb", "lib/cijoe/git.rb", "lib/cijoe/public", "lib/cijoe/public/favicon.ico", "lib/cijoe/public/octocat.png", "lib/cijoe/public/screen.css", "lib/cijoe/queue.rb", "lib/cijoe/server.rb", "lib/cijoe/version.rb", "lib/cijoe/views", "lib/cijoe/views/json.erb", "lib/cijoe/views/template.erb", "lib/cijoe.rb", "bin/cijoe", "test/fixtures", "test/fixtures/payload.json", "test/fixtures/testrepo.git", "test/fixtures/testrepo.git/config", "test/fixtures/testrepo.git/HEAD", "test/fixtures/testrepo.git/hooks", "test/fixtures/testrepo.git/hooks/ctags", "test/fixtures/testrepo.git/hooks/post-checkout", "test/fixtures/testrepo.git/hooks/post-commit", "test/fixtures/testrepo.git/hooks/post-merge", "test/fixtures/testrepo.git/hooks/post-rewrite", "test/fixtures/testrepo.git/hooks/test_env", "test/fixtures/testrepo.git/objects", "test/fixtures/testrepo.git/objects/01", "test/fixtures/testrepo.git/objects/01/8141ee284c47db643e5fd6da9e639f32f891ef", "test/fixtures/testrepo.git/objects/10", "test/fixtures/testrepo.git/objects/10/8a24438162962044e50444d7da93d0b43b8d7b", "test/fixtures/testrepo.git/objects/2d", "test/fixtures/testrepo.git/objects/2d/865775b97c23770153cfac281222a8596e7bb0", "test/fixtures/testrepo.git/objects/33", "test/fixtures/testrepo.git/objects/33/0f3a6ea1da0fcbd1faa9a85dd1fbdbd7e368db", "test/fixtures/testrepo.git/objects/a9", "test/fixtures/testrepo.git/objects/a9/99a0c211215fd28e77d6a7c66ade6ec76ccbcb", "test/fixtures/testrepo.git/objects/b5", "test/fixtures/testrepo.git/objects/b5/57b867cfc8b86aa5ad73729ffe0017922fbce1", "test/fixtures/testrepo.git/refs", "test/fixtures/testrepo.git/refs/heads", "test/fixtures/testrepo.git/refs/heads/master", "test/helper.rb", "test/test_cijoe.rb", "test/test_cijoe_build.rb", "test/test_cijoe_config.rb", "test/test_cijoe_git.rb", "test/test_cijoe_queue.rb", "test/test_cijoe_server.rb", "test/test_hooks.rb"]
  s.homepage = "http://github.com/defunkt/cijoe"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.0"
  s.summary = "cijoe builds your builds."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<choice>, [">= 0"])
      s.add_runtime_dependency(%q<sinatra>, [">= 0"])
      s.add_runtime_dependency(%q<erubis>, [">= 0"])
      s.add_runtime_dependency(%q<multi_json>, [">= 0"])
      s.add_runtime_dependency(%q<tinder>, [">= 1.4.0"])
      s.add_development_dependency(%q<rack-test>, [">= 0"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
      s.add_development_dependency(%q<minitest>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rdoc>, [">= 0"])
    else
      s.add_dependency(%q<choice>, [">= 0"])
      s.add_dependency(%q<sinatra>, [">= 0"])
      s.add_dependency(%q<erubis>, [">= 0"])
      s.add_dependency(%q<multi_json>, [">= 0"])
      s.add_dependency(%q<tinder>, [">= 1.4.0"])
      s.add_dependency(%q<rack-test>, [">= 0"])
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<minitest>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rdoc>, [">= 0"])
    end
  else
    s.add_dependency(%q<choice>, [">= 0"])
    s.add_dependency(%q<sinatra>, [">= 0"])
    s.add_dependency(%q<erubis>, [">= 0"])
    s.add_dependency(%q<multi_json>, [">= 0"])
    s.add_dependency(%q<tinder>, [">= 1.4.0"])
    s.add_dependency(%q<rack-test>, [">= 0"])
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<minitest>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rdoc>, [">= 0"])
  end
end
