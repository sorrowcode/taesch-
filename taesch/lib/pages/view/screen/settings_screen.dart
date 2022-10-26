import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../view_model/settings_screen_vm.dart';

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
      value: SettingsScreenVM.isDarkMode,
      onChanged: (bool value) {
        setState(() {
          SettingsScreenVM.isDarkMode = value;
        });
      },
      secondary: const Icon(Icons.sunny),
    );
  }
}
