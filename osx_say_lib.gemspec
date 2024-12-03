# osx_say_lib.gemspec
Gem::Specification.new do |spec|
  spec.name          = "osx_say_lib"
  spec.version       = "0.1.0"
  spec.authors       = ["Your Name"]
  spec.email         = ["your.email@example.com"]

  spec.summary       = "A macOS text-to-speech library using `say` command."
  spec.description   = "Automates repetitive tasks with text-to-speech functionality leveraging macOS's `say` command."
  spec.homepage      = "https://github.com/yourusername/osx_say_lib"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*", "README.md", "LICENSE"]
  spec.require_paths = ["lib"]

  spec.add_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
