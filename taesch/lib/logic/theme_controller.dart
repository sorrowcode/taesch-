import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taesch/logic/theme_controller_provider.dart';

class ThemeController extends ChangeNotifier {
  static const themePrefKey = 'theme';
  bool _darkTheme = false;
  final SharedPreferences _prefs;

  ThemeController(this._prefs) {
    // load theme from preferences on initialization
    _darkTheme = _prefs.getBool("theme") ?? false;
  }

  /// get the current theme
  bool get darkTheme => _darkTheme;

  set darkTheme(bool darkTheme) {
    _darkTheme = darkTheme;

    // notify the app that the theme was changed
    notifyListeners();

    // store updated theme on disk
    _prefs.setBool(themePrefKey, darkTheme);
  }

  /// get the controller from any page of your app
  static ThemeController of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<ThemeControllerProvider>()
            as ThemeControllerProvider;
    return provider.controller;
  }
}
