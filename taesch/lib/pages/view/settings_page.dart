import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

/// shows the shopping list elements
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Settings Page"),
    );
  }
}
