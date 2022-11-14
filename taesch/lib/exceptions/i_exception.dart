import 'package:taesch/middleware/log/log_level.dart';
import 'package:taesch/middleware/log/logger_wrapper.dart';
import 'package:taesch/model/log_message.dart';

abstract class IException implements Exception {
  final String cause;
  final LoggerWrapper logger = LoggerWrapper();
  
  IException({required this.cause});
  
  void logCause(LogLevel level);
}