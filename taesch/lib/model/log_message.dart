class LogMessage {
  dynamic message;
  dynamic title;
  StackTrace? stackTrace;

  LogMessage({this.message, this.title, this.stackTrace});
}