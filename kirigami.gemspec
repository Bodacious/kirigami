
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "kirigami/version"

Gem::Specification.new do |spec|
  spec.name          = "kirigami"
  spec.version       = Kirigami::VERSION
  spec.authors       = ["Bodacious"]
  spec.email         = ["gavin@gavinmorric.com"]

  spec.summary       = %q{Cut down your assets/images to web-friendly sizes}
  spec.description   = %q{Cut down your assets/images to a web-friendly sizes}
  spec.homepage      = "https://github.com/bodacious/kirigami"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  # spec.bindir        = "exe"
  # spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'mini_magick', ">= 4.9.4"
  spec.add_dependency 'activesupport'
  spec.add_dependency 'rails', ">= 3.0.0"
  spec.add_development_dependency "bundler", ">= 1.16.0"
  spec.add_development_dependency "rake", ">= 12.3.3"
end
