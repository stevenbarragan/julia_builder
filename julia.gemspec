# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'julia/version'

Gem::Specification.new do |spec|
  spec.name          = "julia_builder"
  spec.version       = Julia::VERSION
  spec.authors       = ["Steven Barragán"]
  spec.email         = ["me@steven.mx"]

  spec.summary       = %q{Export your queries easily and fast}
  spec.description   = %q{Create flexible builders to export your queries easy than ever}
  spec.homepage      = "https://github.com/stevenbarragan/julia_builder"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
