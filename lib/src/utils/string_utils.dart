/// Extension methods on [String] to provide additional utility functions.
extension StringUtils on String {
  /// Returns a copy of the string with the first letter capitalized.
  ///
  /// If the string is empty, it returns the original string.
  ///
  /// Example:
  /// ```dart
  /// 'link_io'.capitalize(); // 'Link_io'
  /// ''.capitalize();        // ''
  /// ```
  String capitalize() =>
      isEmpty ? this : "${this[0].toUpperCase()}${substring(1)}";
}