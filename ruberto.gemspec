# frozen_string_literal: true

require_relative "lib/ruberto/version"

Gem::Specification.new do |spec|
  spec.name = "ruberto"
  spec.version = Ruberto::VERSION
  spec.authors = ["Bruno Costanzo", "Nicolás Galdámez"]
  spec.email = ["bruno.costanzo@unagisoftware.com", "nicolas.galdamez@unagisoftware.com"]

  spec.summary = "Ruby bindings for Uber's API"
  spec.description = "Ruby bindings for Uber's API"
  spec.homepage = "https://github.com/unagisoftware/ruberto"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/unagisoftware/ruberto"
  spec.metadata["changelog_uri"] = "https://github.com/unagisoftware/ruberto/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", "~> 2.0"
  spec.add_dependency "faraday-net_http_persistent"
end
