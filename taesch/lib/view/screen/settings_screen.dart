import 'package:flutter/material.dart';
import 'package:taesch/controller/theme_controller.dart';
import 'package:taesch/middleware/log/log_level.dart';
import 'package:taesch/middleware/log/logger_wrapper.dart';
import 'package:taesch/model/log_message.dart';
import 'package:taesch/view_model/screen/settings_screen_vm.dart';
import 'package:intl/intl.dart';

/// shows the shopping list elements
class SettingsScreen extends StatefulWidget {
  final SettingsScreenVM _vm = SettingsScreenVM();

  SettingsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  LoggerWrapper logger = LoggerWrapper();
  var formatter = NumberFormat.decimalPattern();

  @override
  Widget build(BuildContext context) {
    logger.log(
        level: LogLevel.info,
        logMessage: LogMessage(message: "entered settings screen"));
    return ListView(
      children: [
        SwitchListTile(
          title: Text(widget._vm.switchTitle),
          value: ThemeController.of(context).darkTheme,
          activeColor: Theme.of(context).secondaryHeaderColor,
          onChanged: (bool value) {
            logger.log(
            level: LogLevel.info,
            logMessage: LogMessage(
            message:
            "switched ${widget._vm.switchTitle} button to $value"));
            setState(() {
              ThemeController.of(context).darkTheme = value;
            });
          },
          secondary: Icon(
            Icons.sunny,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        ListTile(
          title: Text(widget._vm.radTitle),
          trailing: DropdownButton(
            value: widget._vm.repo.searchRadius,
            items: (widget._vm.radValues.map((int e) => DropdownMenuItem(value: e,child: Text(formatter.format(e)))).toList()),
            onChanged: (int? value) {
              logger.log(
                level: LogLevel.info,
                logMessage: LogMessage(
                  message:
                  "switched ${widget._vm.switchTitle} button to $value"));
              setState(() {
                widget._vm.repo.searchRadius = value!;
              });
            },
          ),
        )
      ],
    );

  }
}
