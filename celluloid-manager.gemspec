# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "celluloid-manager"
  spec.version       = "0.0.0.pre"
  spec.authors       = ["Donovan Keme"]
  spec.email         = ["code@extremist.digital"]

  spec.summary       = "Auxiliary Actor::System management actor for Celluloid."
  spec.description   = "Modular system for outfitting an actor who maintains the Actor::System."
  spec.homepage      = "http://github.com/celluloid/celluloid-manager"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|examples|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "celluloid", "~> 0.17.0"
end
