import 'dart:isolate';

import 'package:flutter/material.dart';

class IsolateExecutor {
  final Function _function;

  IsolateExecutor(this._function);

  Future<void> run(SendPort sendPort) async {
    WidgetsFlutterBinding.ensureInitialized();
    await _function();
    Isolate.exit(sendPort, "Isolate finished.");
  }
}
