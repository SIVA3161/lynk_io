
import 'package:logger/logger.dart';

class AppLogger {
  static final _logger = Logger();

  static void log(String message) => _logger.i(message);
  static void info(String message) => _logger.i(message);
  static void debug(String message) => _logger.d(message);
  static void warning(String message) => _logger.w(message);
  static void error(String message) => _logger.e(message);
  static void trace(String message) => _logger.t(message);
}