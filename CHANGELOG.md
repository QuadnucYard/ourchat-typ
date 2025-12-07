# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [0.2.1] - 2025-12-07

- Update to typst 0.14. No API or output change.
- Fixed that image assets are unexpected excluded.

## [0.2.0] - 2025-07-14

### Added

- Support for QQNT and Discord themes.

### Changed

- Improved customizability: almost all colors and layout parameters are now user-configurable. Theme inheritance is supported.

### Breaking

- Simplified chat declaration API. Now, reusable users must be created, and the `with-side-user` helper is provided to reduce repeated declarations for the same user in consecutive messages. Please refer to the README and gallery for the updated syntax.

## [0.1.0] - 2025-01-12

### Added

- Initial release.
