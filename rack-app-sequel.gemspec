# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack/app/sequel/version'

Gem::Specification.new do |spec|
  spec.name          = "rack-app-sequel"
  spec.version       = Rack::App::SeQueL::VERSION
  spec.authors       = ["Adam Luzsi"]
  spec.email         = ["adamluzsi@gmail.com"]

  spec.summary       = %q{rack-app sequel integration for db migration and modelling}
  spec.description   = %q{rack-app sequel integration for db migration and modelling}
  spec.homepage      = "https://github.com/rack-app/rack-app-sequel"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency "sequel", ">= 4.0.0"
end
