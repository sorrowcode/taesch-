import 'package:logger/logger.dart';
import 'package:taesch/middleware/log/log_level.dart';
import 'package:taesch/model/log_message.dart';

class LoggerWrapper {
  static Logger? _errorLogger;
  static Logger? _logger;

  LoggerWrapper() {
    _errorLogger ??= Logger(printer: PrettyPrinter());
    _logger ??= Logger(printer: PrettyPrinter(methodCount: 0));
  }

  void log({required LogLevel level, required LogMessage logMessage}) {
    switch (level) {
      case LogLevel.debug:
        _logger!.d(logMessage.message, logMessage.title, logMessage.stackTrace);
        break;
      case LogLevel.info:
        _logger!.i(logMessage.message, logMessage.title, logMessage.stackTrace);
        break;
      case LogLevel.error:
        _errorLogger!
            .e(logMessage.message, logMessage.title, logMessage.stackTrace);
        break;
    }
  }
}
