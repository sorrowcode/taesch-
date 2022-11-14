import 'package:logger/logger.dart';
import 'package:taesch/middleware/log/log_level.dart';

class LoggerWrapper {
  late Logger _logger;

  LoggerWrapper() {
    _logger = Logger(
      printer: PrettyPrinter(),
    );
  }

  void log({required LogLevel level, required String message}) {
    switch(level) {
      case LogLevel.debug:
        _logger.d(message);
        break;
      case LogLevel.info:
        _logger.i(message);
        break;
      case LogLevel.error:
        _logger.e(message);
        break;
    }
  }
}