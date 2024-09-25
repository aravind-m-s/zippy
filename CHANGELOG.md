# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial creation of `ZippyForm` widget with support for custom fields.
- Added support for Material and Cupertino platform styles.
- Added customizable buttons for navigation (`Next`, `Previous`, `Submit`, `Back`).
- Integrated field validation for text fields, number fields, dropdowns, and more.
- Introduced advanced dropdown with support for multiple selection.
- Added horizontal step progress bar to display current form step.
- Customizable error widget for handling field validation errors.
- Support for hidden fields that are submitted along with form data.
- Bloc-based state management for form field handling and submissions.
- Added customizable padding and positioning for form elements and buttons.

### Changed
- Refactored field rendering logic to improve performance.
- Updated the form navigation logic to handle edge cases in the stepper widget.

### Fixed
- Fixed an issue where certain fields were not rendering correctly in debug mode.
- Resolved a bug with dropdown fields not triggering the `onDropdownChange` callback properly.

## [0.0.1] - 2024-09-25

### Added
- Initial release of the `Zippy` package.
- Basic form field support including text fields, number fields, email, dropdowns, checkboxes, and radio buttons.
- Stepper functionality for multi-step forms.
- Customizable next, previous, and submit buttons.
