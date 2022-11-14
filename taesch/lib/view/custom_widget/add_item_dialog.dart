import 'package:flutter/material.dart';
import 'package:taesch/middleware/log/log_level.dart';
import 'package:taesch/middleware/log/logger_wrapper.dart';
import 'package:taesch/model/error_case.dart';
import 'package:taesch/view_model/custom_widget/add_item_dialog_vm.dart';

class AddItemDialog extends StatefulWidget {
  final _vm = AddItemDialogVM();

  AddItemDialog({super.key});

  @override
  State<StatefulWidget> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  final _formKey = GlobalKey<FormState>();
  LoggerWrapper logger = LoggerWrapper();

  @override
  Widget build(BuildContext context) {
    logger.log(level: LogLevel.debug, message: "entered add item dialog");
    return AlertDialog(
        title: Text(widget._vm.title),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                  validator: (value) {
                    logger.log(level: LogLevel.debug, message: "${widget._vm.textFormHint} validation: $value");
                    return widget._vm.validateShoppingListItem(value)?.message;
                  },
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: widget._vm.textFormHint))
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
              child: const Icon(Icons.check),
              onPressed: () {
                logger.log(level: LogLevel.debug, message: "check button pressed");
                if (_formKey.currentState!.validate()) {
                  logger.log(level: LogLevel.debug, message: "form valid");
                  setState(() {
                    widget._vm.repository.shoppingListItems
                        .add(widget._vm.temp);
                    widget._vm.repository.shoppingListSize.value =
                        widget._vm.repository.shoppingListItems.length;
                  });
                  Navigator.of(context).pop();
                } else {
                  logger.log(level: LogLevel.debug, message: "invalid form");
                }
              }),
          TextButton(
            child: const Icon(Icons.close),
            onPressed: () {
              logger.log(level: LogLevel.debug, message: "pressed close button");
              Navigator.of(context).pop();
            },
          )
        ]);
  }
}
