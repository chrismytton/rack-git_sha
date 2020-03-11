# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rack/git_sha/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Chris Mytton"]
  gem.email         = ["self@hecticjeff.net"]
  gem.description   = %q{Serve up the current git commit SHA from rack}
  gem.summary       = %q{Tiny rack application that serves up the currently deployed git commit SHA}
  gem.homepage      = "https://github.com/hecticjeff/rack-git_sha"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "rack-git_sha"
  gem.require_paths = ["lib"]
  gem.version       = Rack::GitSha::VERSION

  gem.add_development_dependency 'rspec', '~> 3.9.0'
  gem.add_development_dependency 'rack-test', '~> 1.1.0'
  gem.add_development_dependency 'rake', '~> 13.0.1'
end
