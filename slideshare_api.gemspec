# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'slideshare_api/version'

Gem::Specification.new do |spec|
  spec.name          = 'slideshare_api'
  spec.version       = SlideshareApi::VERSION
  spec.authors       = ['Jeremy Venezia']
  spec.email         = ['veneziajeremy@gmail.com']
  spec.summary       = %q{Slideshare ruby wrapper for the Slideshare API.}
  spec.description   = %q{Slideshare ruby wrapper for the Slideshare API.}
  spec.homepage      = 'https://github.com/jvenezia/slideshare_api'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(spec|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'

  spec.add_dependency 'faraday', '~> 0'
  spec.add_dependency 'faraday_middleware', '~> 0'
end
