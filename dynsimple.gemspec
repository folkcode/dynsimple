# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dynsimple/version'

Gem::Specification.new do |spec|
  spec.name          = 'dynsimple'
  spec.version       = DynSimple::VERSION
  spec.authors       = ['Björn Albers']
  spec.email         = ['bjoernalbers@googlemail.com']
  spec.summary       = "#{spec.name}-#{spec.version}"
  spec.description   = 'Dynamic IP + DNSimple + Phaser Beams = DynSimple'
  spec.homepage      = 'https://github.com/bjoernalbers/dynsimple'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'httparty', '~> 0.12'
  spec.add_development_dependency 'mixlib-cli', '~> 1.3'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 2.14'
end
