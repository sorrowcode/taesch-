import 'package:logger/logger.dart';
import 'package:taesch/middleware/log/log_level.dart';
import 'package:taesch/model/log_message.dart';

class LoggerWrapper {
  static Logger? _logger;

  LoggerWrapper() {
    _logger ??= Logger(printer: PrettyPrinter());
  }

  void log({required LogLevel level, required LogMessage logMessage}) {
    switch(level) {
      case LogLevel.debug:
        _logger!.d(logMessage.message, logMessage.error, logMessage.stackTrace);
        break;
      case LogLevel.info:
        _logger!.i(logMessage.message, logMessage.error, logMessage.stackTrace);
        break;
      case LogLevel.error:
        _logger!.e(logMessage.message, logMessage.error, logMessage.stackTrace);
        break;
    }
  }
}