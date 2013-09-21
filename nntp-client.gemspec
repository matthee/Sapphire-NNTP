# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nntp/client/version'

Gem::Specification.new do |spec|
  spec.name          = "nntp-client"
  spec.version       = Nntp::Client::VERSION
  spec.authors       = ["Matthias Link"]
  spec.email         = ["matthias@link.co.at"]
  spec.description   = %q{NNTP-Client used for Sapphire}
  spec.summary       = %q{NNTP-Client used for Sapphire grabbing newsgroup posts}
  spec.homepage      = "http://sapphire.iicm.tugraz.at"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
