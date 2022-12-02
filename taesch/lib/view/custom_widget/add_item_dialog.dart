import 'package:flutter/material.dart';
import 'package:taesch/middleware/log/log_level.dart';
import 'package:taesch/middleware/log/logger_wrapper.dart';
import 'package:taesch/model/error_case.dart';
import 'package:taesch/model/log_message.dart';
import 'package:taesch/view_model/custom_widget/add_item_dialog_vm.dart';

class AddItemDialog extends StatefulWidget {
  const AddItemDialog({super.key});

  @override
  State<StatefulWidget> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  final _formKey = GlobalKey<FormState>();
  final _vm = AddItemDialogVM();
  LoggerWrapper logger = LoggerWrapper();

  @override
  Widget build(BuildContext context) {
    logger.log(
        level: LogLevel.info,
        logMessage: LogMessage(message: "entered add item dialog"));
    var tagEditController = TextEditingController();
    tagEditController.addListener(() => {
          if (_vm.tagValidator(tagEditController.text))
            {
              setState(() {
                tagEditController.text = '';
              })
            }
        });

    return AlertDialog(
        title: Text(_vm.title),
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
                                "${_vm.textFormHint} validation: ${_vm.validateShoppingListItem(value)?.message}"));
                    return _vm.validateShoppingListItem(value)?.message;
                  },
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: _vm.textFormHint)),
              TextFormField(
                validator: (value) {
                  return _vm.validateTags(value);
                },
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: _vm.tagFormHint),
                controller: tagEditController,
              ),
              // widget._vm.tags.map((e) => Text(e.name)).toList()<vdhjavdjhh
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    children: _vm.tags
                        .map((e) => TextButton(
                            onPressed: () => {
                                  setState(() {
                                    _vm.tags.remove(e);
                                  })
                                },
                            child: Text(e.name)))
                        .toList(),
                  ))
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
                  setState(() {
                    _vm.repository.sqlDatabase
                        .insertProduct(true, _vm.temp!)
                        .then((value) {
                      _vm.repository.sqlDatabase
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
