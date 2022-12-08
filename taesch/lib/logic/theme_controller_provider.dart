import 'package:flutter/material.dart';
import 'package:taesch/logic/theme_controller.dart';

class ThemeControllerProvider extends InheritedWidget {
  final ThemeController controller;

  const ThemeControllerProvider(
      {super.key, required this.controller, required Widget child})
      : super(child: child);

  @override
  bool updateShouldNotify(ThemeControllerProvider oldWidget) =>
      controller != oldWidget.controller;
}
