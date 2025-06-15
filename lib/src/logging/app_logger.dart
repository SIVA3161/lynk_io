
import 'package:logger/logger.dart';

/// A centralized logging utility for different levels of logs.
///
/// Built on top of the `logger` package, this class simplifies log usage
/// throughout the application by exposing static methods.
///
/// Example:
/// ```dart
/// AppLogger.info('Fetching data...');
/// AppLogger.error('Something went wrong!');
/// ```
class AppLogger {
  static final _logger = Logger();

  /// Logs a general information message.
  static void log(String message) => _logger.i(message);

  /// Logs an info-level message.
  static void info(String message) => _logger.i(message);

  /// Logs a debug-level message.
  static void debug(String message) => _logger.d(message);

  /// Logs a warning-level message.
  static void warning(String message) => _logger.w(message);

  /// Logs an error-level message.
  static void error(String message) => _logger.e(message);

  /// Logs a trace-level message.
  static void trace(String message) => _logger.t(message);
}