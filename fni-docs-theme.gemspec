# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "fni-docs-theme"
  spec.version       = "0.6.2"
  spec.authors       = ["Patrick Marsceill", "Ken Hill"]
  spec.email         = ["patrick.marsceill@gmail.com", "rubygems@hill.ae"]

  spec.summary       = %q{Fork of just-the-docs}
  spec.homepage      = "https://github.com/dealertrack/fni-docs-theme"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").select { |f| 
    f.match(%r{^(assets|bin|_layouts|_includes|lib|Rakefile|_sass|LICENSE|README)}i)
  }
  spec.executables   << 'just-the-docs'
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.4"
  spec.add_runtime_dependency "jekyll", "~> 4.3"
  spec.add_runtime_dependency "jekyll-include-cache", "~> 0.2"
  spec.add_runtime_dependency "rake", ">= 12.3.1", "< 13.1.0"
  spec.add_runtime_dependency "webrick", "~> 1.8"
  spec.add_runtime_dependency "digest", "~> 3.1"
end
