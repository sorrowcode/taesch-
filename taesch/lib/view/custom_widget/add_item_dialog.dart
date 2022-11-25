import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:taesch/middleware/log/log_level.dart';
import 'package:taesch/middleware/log/logger_wrapper.dart';
import 'package:taesch/model/error_case.dart';
import 'package:taesch/model/log_message.dart';
import 'package:taesch/model/tag.dart';
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
    logger.log(
        level: LogLevel.info,
        logMessage: LogMessage(message: "entered add item dialog"));
    var tagEditController = TextEditingController();
    tagEditController.addListener(() => {
      if (tagEditController.text.endsWith(' ')||tagEditController.text.endsWith(',')) {
        tagEditController.text = tagEditController.text.substring(0,tagEditController.text.length-1),//cutts the last character
        widget._vm.tags.add(Tag(name: tagEditController.text)),
        tagEditController.text = '',
        setState(() {})
      }
    });

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
                    logger.log(
                        level: LogLevel.debug,
                        logMessage: LogMessage(
                            message:
                                "${widget._vm.textFormHint} validation: ${widget._vm.validateShoppingListItem(value)?.message}"));
                    return widget._vm.validateShoppingListItem(value)?.message;
                  },
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: widget._vm.textFormHint)),
              TextFormField(
                validator: (value) {
                  log('what is the Value' + value.toString());
                  return widget._vm.validateTags(value);
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: widget._vm.tagFormHint),
                controller: tagEditController,
              ),
              // widget._vm.tags.map((e) => Text(e.name)).toList()
              Row(children: widget._vm.tags.map((e) => IconButton(onPressed: ()=>{widget._vm.tags.remove(e),setState((){})},icon: Text(e.name))).toList(),)
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
              child: const Icon(Icons.check),
              onPressed: () {
                logger.log(
                    level: LogLevel.info,
                    logMessage: LogMessage(message: "check button pressed"));
                if (_formKey.currentState!.validate()) {
                  log(widget._vm.temp.toString() +'afterValidation');
                  setState(() {
                    widget._vm.repository.sqlDatabase
                        .insertProduct(true, widget._vm.temp!)
                        .then((value) {
                      widget._vm.repository.sqlDatabase
                          .getProductList(true)
                          .then((value) {
                        logger.log(
                            level: LogLevel.debug,
                            logMessage: LogMessage(message: "form valid"));
                        Navigator.of(context).pop(value);
                      });
                    });
                  });
                } else {
                  logger.log(
                      level: LogLevel.debug,
                      logMessage: LogMessage(message: "invalid form"));
                }
              }),
          TextButton(
            child: const Icon(Icons.close),
            onPressed: () {
              logger.log(
                  level: LogLevel.debug,
                  logMessage: LogMessage(message: "pressed close button"));
              Navigator.of(context).pop();
            },
          )
        ]);
  }
}
