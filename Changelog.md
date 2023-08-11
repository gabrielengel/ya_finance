# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).


## [0.0.4] - 2023-08-11

### Added
- TESTS: Added vcr+webmock gems to test API calls
- Implemented basic tests for `current` methods
- Changelog.md

### Fixed
- Cleaned up HTTP class debugs

### Changed
- `current.options` now returns a hash with the keys `puts` and `calls` containing the contracts


## [0.0.3] - 2023-08-10
### Fixed
- `bin/yafin` path on gemspec.


## [0.0.2] - 2023-08-10
### Added
- `bin/yafin` executable to gemspec allowing CLI usage


## [0.0.1] - 2023-08-10

### Added
- Created base gem architecture of classes and expected methods
- Organized Readme
