import 'package:taesch/exceptions/i_exception.dart';
import 'package:taesch/middleware/log/log_level.dart';
import 'package:taesch/model/log_message.dart';

class LoginException extends IException {
  LoginException({required super.cause});

  @override
  void logCause() {
    logger.log(
        level: LogLevel.error,
        logMessage: LogMessage(
          message: cause,
          title: toString(),
        ));
  }
}