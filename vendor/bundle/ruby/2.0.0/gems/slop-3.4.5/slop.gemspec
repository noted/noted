Gem::Specification.new do |s|
  s.name        = 'slop'
  s.version     = '3.4.5'
  s.summary     = 'Simple Lightweight Option Parsing'
  s.description = 'A simple DSL for gathering options and parsing the command line'
  s.author      = 'Lee Jarvis'
  s.email       = 'ljjarvis@gmail.com'
  s.homepage    = 'http://github.com/injekt/slop'
  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- test/*`.split("\n")
  s.license     = 'MIT'

  s.required_ruby_version = '>= 1.8.7'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'minitest', '~> 5.0.0'
end
