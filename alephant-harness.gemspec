# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'alephant/harness/version'

Gem::Specification.new do |spec|
  spec.name          = "alephant-harness"
  spec.version       = Alephant::Harness::VERSION
  spec.authors       = ["BBC News"]
  spec.email         = ["D&ENewsFrameworksTeam@bbc.co.uk"]
  spec.summary       = %q{Stuff}
  spec.description   = %q{More Stuff}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "aws-sdk-sqs"
  spec.add_runtime_dependency "aws-sdk-s3"
  spec.add_runtime_dependency "aws-sdk-dynamodb"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3"
  spec.add_development_dependency "pry"
end
