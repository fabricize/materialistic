# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'materialistic/version'

Gem::Specification.new do |spec|
  spec.name          = "materialistic"
  spec.version       = Materialistic::VERSION
  spec.authors       = ["Yasuaki Uechi"]
  spec.email         = ["uetchy@randompaper.co"]
  spec.summary       = %q{Clarify materials by MPN, SKU and vague material name.}
  spec.description   = %q{Clarify materials by MPN, SKU and vague material name.}
  spec.homepage      = "https://github.com/uetchy/materialistic"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "pry-byebug"

  spec.add_dependency "mechanize"
end
