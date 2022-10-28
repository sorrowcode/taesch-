import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:taesch/app.dart';
import 'package:taesch/view_model/screen/settings_screen_vm.dart';

/// shows the shopping list elements
class SettingsScreen extends StatefulWidget {
  final SettingsScreenVM _vm = SettingsScreenVM();

  SettingsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: const Text('Dark Mode'),
      value: widget._vm.repository.isDarkModeEnabled,
      onChanged: (bool value) {
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
