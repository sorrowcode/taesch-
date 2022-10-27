import 'package:flutter/material.dart';
import 'package:taesch/api/repository.dart';
import 'package:taesch/app.dart';

/// vm for [App] view
class AppVM {
  String appTitle = "Taesch!";
  Repository repository = Repository();
  ThemeMode mode = ThemeMode.light;
}
