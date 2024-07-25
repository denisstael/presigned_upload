## [Unreleased]

## [0.1.0] - 2023-11-23

- Initial release

## [0.2.0] - 2024-07-25

- Removed `store_path` attribute from migration
- Moved `store_path` from `before_create` callback to `store_dir` instance method
- The `store_path` now is mounted when it is called, joining `store_dir` + `original_name`
- Added README documentation and installation instructions
- Added `install_generator.rb` to generate the PresignedUpload default initializer