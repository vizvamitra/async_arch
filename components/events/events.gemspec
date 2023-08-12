# frozen_string_literal: true

require_relative "lib/events/version"

Gem::Specification.new do |spec|
  spec.name = "events"
  spec.version = Events::VERSION
  spec.authors = ["vizvamitra"]
  spec.email = ["vizvamitra@users.noreply.github.com"]

  spec.summary = "Popug events"
  spec.description = "Popug Inc. events library"
  spec.homepage = "https://github.com/vizvamitra/async_auth"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://popug.inc"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/vizvamitra/async_auth"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "example-gem", "~> 1.0"
end
