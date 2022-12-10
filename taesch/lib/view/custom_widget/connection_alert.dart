
import 'package:flutter/material.dart';
import 'package:taesch/view_model/custom_widget/connection_alert_vm.dart';

class ConnectionAlert extends AlertDialog {

  final _vm = ConnectionAlertVM();

  ConnectionAlert({super.key});


  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: Text(_vm.titleText),
      content: Text(_vm.contentText),
      actions: [
        TextButton(
          onPressed: () { _vm.openSettings(); Navigator.of(context).pop();},
          child: Text('Settings'))
      ],
    );
  }

}