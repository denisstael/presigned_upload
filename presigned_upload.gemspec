# frozen_string_literal: true

require_relative "lib/presigned_upload/version"

Gem::Specification.new do |spec|
  spec.name = "presigned_upload"
  spec.version = PresignedUpload::VERSION
  spec.authors = ["Denis Stael"]
  spec.email = ["denissantistael@gmail.com"]

  spec.summary = "Control model associated files uploads via presigned URLs to cloud storage services."
  spec.description = <<-EOF
    "Handle direct file uploads to cloud storage services via presigned URLs."
  EOF

  spec.homepage = "https://github.com/denisstael/presigned_upload"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/denisstael/presigned_upload"
  spec.metadata["documentation_uri"] = "https://rubydoc.info/gems/presigned_upload/#{PresignedUpload::VERSION}"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end

  spec.require_paths = ["lib"]

  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 1.21"
  spec.add_development_dependency "sqlite3", "~> 1.4.2"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
