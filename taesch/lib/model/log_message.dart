class LogMessage {
  dynamic message;
  dynamic error;
  StackTrace? stackTrace;

  LogMessage({this.message, this.error, this.stackTrace});
}