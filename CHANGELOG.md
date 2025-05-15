## [1.0.1] - 2025-05-15

### Added
- `loadingWidget` parameter in `IframeCashPay` to allow custom loading indicators.
- `errorWidget` parameter in `IframeCashPay` to allow custom error UI with retry support.

### Changed
- Enhanced error and loading state handling using `Stack` overlay to display widgets dynamically.
- Automatic retry mechanism added with customizable button when loading fails.

### Fixed
- Improved stability when encountering HTTP and load errors in the iframe webview.



## 1.0.0

- Initial release of modified CashPay iframe integration
- Migrated from webview_flutter to flutter_inappwebview
- Added support for JSON messages