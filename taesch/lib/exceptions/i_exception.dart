import 'package:taesch/middleware/log/logger_wrapper.dart';

abstract class IException implements Exception {
  final String cause;
  final LoggerWrapper logger = LoggerWrapper();

  IException({required this.cause});

  void logCause();
}
