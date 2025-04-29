# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Fixed
- Fix: `@8110' is not allowed as an instance variable name
- Fix NoMethodError in `GS1::Barcode::Healthcare#to_s`

## [2.0.2] - 2025-04-23
### Fixed
- Fix the CI release pipeline

## [2.0.1] - 2025-04-23
### Fixed
- Fix the CI release pipeline

## [2.0.0] - 2025-04-22
### Changed
- Minimum supported version of Ruby is now 3.0.5 (breaking change)

- Extra elements in barcodes are now ignored (breaking change). Set the
    `ignore_extra_barcode_elements` configuration option to `false` to restore
    previous behavior

- AI classes are lazy loaded now (possibly breaking change)

### Added
- Add a new option (`ignore_extra_barcode_elements`) to configure if extra
    elements in barcodes should be reported as an error or ignored. By default,
    ignore

- Added the `GS1.ai_classes` method. This contains all AI classes. This is the
    same as `GS1::AI_CLASSES` from previous versions, buy lazy loaded

- All application identifiers (as of 2025-01-30) are now recognized

### Removed
- Removed the `GS1::AI_CLASSES` constant. Use `GS1.ai_classes` instead
- The following classes have been removed: `GS1::Batch` and `GS1::SerialNumber`.
    They have been replaced with generated anonymous classes.

## [1.1.0] - 2021-08-23

### Added
- Adds support to calculating checksum for GSIN

## [1.0.0] - 2019-08-30

### Changed
- Returns `nil` unless no attribute for barcode segment (breaking change)

### Added
- Add errors to a barcode

### Fixed
- Fix `nil` argument for barcode

[Unreleased]: https://github.com/apoex/gs1/compare/v2.0.2...HEAD

[2.0.2]: https://github.com/apoex/gs1/compare/v2.0.1...v2.0.2
[2.0.1]: https://github.com/apoex/gs1/compare/v2.0.0...v2.0.1
[2.0.0]: https://github.com/apoex/gs1/compare/v1.1.0...v2.0.0
[1.1.0]: https://github.com/apoex/gs1/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/apoex/gs1/releases/tag/v1.0.0
