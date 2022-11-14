import 'package:flutter/material.dart';
import 'package:taesch/app.dart';
import 'package:taesch/middleware/log/log_level.dart';
import 'package:taesch/middleware/log/logger_wrapper.dart';
import 'package:taesch/model/log_message.dart';
import 'package:taesch/view_model/screen/settings_screen_vm.dart';

/// shows the shopping list elements
class SettingsScreen extends StatefulWidget {
  final SettingsScreenVM _vm = SettingsScreenVM();

  SettingsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  LoggerWrapper logger = LoggerWrapper();

  @override
  Widget build(BuildContext context) {
    logger.log(level: LogLevel.debug, logMessage: LogMessage(
        message: "entered settings screen"
    ));
    return SwitchListTile(
      title: Text(widget._vm.switchTitle),
      value: widget._vm.repository.isDarkModeEnabled,
      onChanged: (bool value) {
        logger.log(level: LogLevel.debug, logMessage: LogMessage(
            message: "switched ${widget._vm.switchTitle} button to $value"
        ));
        setState(() {
          widget._vm.repository.isDarkModeEnabled = value;
          if (!value) {
            App.of(context)!.changeTheme(ThemeMode.light);
          } else {
            App.of(context)!.changeTheme(ThemeMode.dark);
          }
        });
      },
      secondary: const Icon(Icons.sunny),
    );
  }
}
