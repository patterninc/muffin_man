require_relative "lib/muffin_man/version"

Gem::Specification.new do |spec|
  spec.name          = "muffin_man"
  spec.version       = MuffinMan::VERSION
  spec.authors       = ["Gavin", "Jason", "Nate"]
  spec.email         = ["gavin@pattern.com", "jason@pattern.com", "nate.salisbury@pattern.com"]

  spec.summary       = "Amazon Selling Partner API client"
  spec.homepage      = "https://github.com/patterninc/muffin_man"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "webmock", "~> 2.1"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "mock_redis", ">=0.14"
  spec.add_runtime_dependency "typhoeus", "~> 1.0", ">= 1.0.1"
  spec.add_runtime_dependency "aws-sigv4", ">= 1.1"
  spec.add_runtime_dependency "aws-sdk-core", ">= 2.4.4"
end
