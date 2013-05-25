# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "memcached"
  s.version = "1.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Evan Weaver"]
  s.cert_chain = ["-----BEGIN CERTIFICATE-----\nMIIDLjCCAhagAwIBAgIBADANBgkqhkiG9w0BAQUFADA9MQ0wCwYDVQQDDARldmFu\nMRgwFgYKCZImiZPyLGQBGRYIY2xvdWRidXIxEjAQBgoJkiaJk/IsZAEZFgJzdDAe\nFw0wNzA5MTYxMDMzMDBaFw0wODA5MTUxMDMzMDBaMD0xDTALBgNVBAMMBGV2YW4x\nGDAWBgoJkiaJk/IsZAEZFghjbG91ZGJ1cjESMBAGCgmSJomT8ixkARkWAnN0MIIB\nIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA5C0Io89nyApnr+PvbNFge9Vs\nyRWAlGBUEMahpXp28VrrfXZT0rAW7JBo4PlCE3jl4nE4dzE6gAdItSycjTosrw7A\nIr5+xoyl4Vb35adv56TIQQXvNz+BzlqnkAY5JN0CSBRTQb6mxS3hFyD/h4qgDosj\nR2RFVzHqSxCS8xq4Ny8uzOwOi+Xyu4w67fI5JvnPvMxqrlR1eaIQHmxnf76RzC46\nQO5QhufjAYGGXd960XzbQsQyTDUYJzrvT7AdOfiyZzKQykKt8dEpDn+QPjFTnGnT\nQmgJBX5WJN0lHF2l1sbv3gh4Kn1tZu+kTUqeXY6ShAoDTyvZRiFqQdwh8w2lTQID\nAQABozkwNzAJBgNVHRMEAjAAMAsGA1UdDwQEAwIEsDAdBgNVHQ4EFgQU+WqJz3xQ\nXSea1hRvvHWcIMgeeC4wDQYJKoZIhvcNAQEFBQADggEBAGLZ75jfOEW8Nsl26CTt\nJFrWxQTcQT/UljeefVE3xYr7lc9oQjbqO3FOyued3qW7TaNEtZfSHoYeUSMYbpw1\nXAwocIPuSRFDGM4B+hgQGVDx8PMGiJKom4qLXjO40UZsR7QyN/u869Vj45LURm6h\nMBcPeqCASI+WNprj9+uZa2kmHiitrFqqfMBNlm5IFbn9XeYSta9AHVvs5QQqV2m5\nhIPfLqCyxsn/YgOGvo6iwyQTWyTswamaAC3HRWZxIS1sfn/Ssqa7E7oQMkv5FAXr\nx5rKePfXINf8XTJczkl9OBEYdE9aNdJsJpXD0asLgGVwBICS5Bjohp6mizJcDC1+\nyZ0=\n-----END CERTIFICATE-----\n"]
  s.date = "2012-12-07"
  s.description = "An interface to the libmemcached C client."
  s.email = ""
  s.extensions = ["ext/extconf.rb"]
  s.extra_rdoc_files = ["BENCHMARKS", "CHANGELOG", "LICENSE", "README.rdoc", "TODO", "ext/libmemcached-0.32/README", "ext/libmemcached-0.32/TODO", "ext/libmemcached-0.32/libmemcached/memcached/README.txt", "lib/memcached.rb", "lib/memcached/behaviors.rb", "lib/memcached/exceptions.rb", "lib/memcached/experimental.rb", "lib/memcached/memcached.rb", "lib/memcached/rails.rb"]
  s.files = ["BENCHMARKS", "CHANGELOG", "LICENSE", "README.rdoc", "TODO", "ext/libmemcached-0.32/README", "ext/libmemcached-0.32/TODO", "ext/libmemcached-0.32/libmemcached/memcached/README.txt", "lib/memcached.rb", "lib/memcached/behaviors.rb", "lib/memcached/exceptions.rb", "lib/memcached/experimental.rb", "lib/memcached/memcached.rb", "lib/memcached/rails.rb", "ext/extconf.rb"]
  s.homepage = "http://evan.github.com/evan/memcached/"
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Memcached", "--main", "README.rdoc", "--exclude=ext/bin", "--exclude=ext/libmemcached-.*/(clients|tests)"]
  s.require_paths = ["lib", "ext"]
  s.rubyforge_project = "evan"
  s.rubygems_version = "2.0.0"
  s.summary = "An interface to the libmemcached C client."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
      s.add_development_dependency(%q<echoe>, [">= 0"])
      s.add_development_dependency(%q<activesupport>, [">= 0"])
    else
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<echoe>, [">= 0"])
      s.add_dependency(%q<activesupport>, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<echoe>, [">= 0"])
    s.add_dependency(%q<activesupport>, [">= 0"])
  end
end
