import 'package:taesch/exceptions/i_exception.dart';
import 'package:taesch/middleware/log/log_level.dart';
import 'package:taesch/model/log_message.dart';

class QueryException extends IException {
  QueryException({required super.cause});

  @override
  void logCause(LogLevel level) {
    logger.log(level: level, logMessage: LogMessage(
      message: cause,
      error: toString(),
    ));
  }
}
