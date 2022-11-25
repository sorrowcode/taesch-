import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'logic/theme_controller.dart';

/// entry point
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final themeController = ThemeController(prefs);
  runApp(App(
    controller: themeController,
  ));
}
