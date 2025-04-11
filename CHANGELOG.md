# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Changed
- Minimum supported version of Ruby is now 3.0.5 (breaking change)

- Extra elements in barcodes are now ignored (breaking change). Set the
    `ignore_extra_barcode_elements` configuration option to `true` to restore
    previous behavior

- AI classes are lazy loaded now (possibly breaking change)

### Added
- Add a new option (`ignore_extra_barcode_elements`) to configure if extra
    elements in barcodes should be reported as an error or ignored. By default,
    ignore

- Added the `GS1.ai_classes` method. This contains all AI classes. This is the
    same as `GS1::AI_CLASSES` from previous versions, buy lazy loaded

### Removed
- Removed the `GS1::AI_CLASSES` constant. Use `GS1.ai_classes` instead

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

[Unreleased]: https://github.com/apoex/gs1/compare/v1.1.0...HEAD

[1.1.0]: https://github.com/apoex/gs1/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/apoex/gs1/releases/tag/v1.0.0
