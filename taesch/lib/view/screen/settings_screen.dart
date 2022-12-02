import 'package:flutter/material.dart';
import 'package:taesch/logic/theme_controller.dart';
import 'package:taesch/middleware/log/log_level.dart';
import 'package:taesch/middleware/log/logger_wrapper.dart';
import 'package:taesch/model/log_message.dart';
import 'package:taesch/view_model/screen/settings_screen_vm.dart';

/// shows the shopping list elements
class SettingsScreen extends StatefulWidget {

  const SettingsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  LoggerWrapper logger = LoggerWrapper();
  final SettingsScreenVM _vm = SettingsScreenVM();

  @override
  Widget build(BuildContext context) {
    logger.log(
        level: LogLevel.info,
        logMessage: LogMessage(message: "entered settings screen"));
    return SwitchListTile(
      title: Text(_vm.switchTitle),
      value: ThemeController.of(context).darkTheme,
      onChanged: (bool value) {
        logger.log(
            level: LogLevel.info,
            logMessage: LogMessage(
                message:
                    "switched ${_vm.switchTitle} button to $value"));
        setState(() {
          ThemeController.of(context).darkTheme = value;
        });
      },
      secondary: const Icon(Icons.sunny),
    );
  }
}
