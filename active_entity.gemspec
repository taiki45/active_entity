# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_entity/version'

Gem::Specification.new do |spec|
  spec.name          = "active_entity"
  spec.version       = ActiveEntity::VERSION
  spec.authors       = ["Taiki Ono"]
  spec.email         = ["taiks.4559@gmail.com"]
  spec.summary       = %q{An Active Model extention for entity.}
  spec.description   = %q{An extension for Active Model to encourage implementing entity.}
  spec.homepage      = "https://github.com/taiki45/active_entity"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activemodel", ">= 4.0"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-doc"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.1"
  spec.add_development_dependency "simplecov"
end
