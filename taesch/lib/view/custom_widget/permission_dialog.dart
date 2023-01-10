import 'package:flutter/material.dart';

class PermissionDialog {
  void showGeolocationPermissionDialog(
      BuildContext context, String title, String content) {
    showDialog(
        context: context,
        builder: (ctx) =>
            AlertDialog(title: Text(title), content: Text(content), actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text("OK"))
            ]));
  }
}
