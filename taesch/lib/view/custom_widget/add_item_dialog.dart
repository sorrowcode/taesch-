import 'package:flutter/material.dart';
import 'package:taesch/middleware/log/log_level.dart';
import 'package:taesch/middleware/log/logger_wrapper.dart';
import 'package:taesch/model/error_case.dart';
import 'package:taesch/model/log_message.dart';
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
          if (widget._vm.tagValidator(tagEditController.text))
            {
              setState(() {
                tagEditController.text = '';
              })
            }
        });

    return AlertDialog(
        title: Text(
          widget._vm.title,
        ),
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

              // widget._vm.tags.map((e) => Text(e.name)).toList()<vdhjavdjhh
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    children: widget._vm.tags
                        .map((e) => TextButton(
                            onPressed: () => {
                                  setState(() {
                                    widget._vm.tags.remove(e);
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
              child: Icon(
                Icons.check,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                logger.log(
                    level: LogLevel.info,
                    logMessage: LogMessage(message: "check button pressed"));
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    widget._vm.sqlRepository.sqlActions
                        .insertProduct(true, widget._vm.temp!)
                        .then((value) {
                      widget._vm.sqlRepository.sqlActions
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
            child: Icon(
              Icons.close,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              logger.log(
                  level: LogLevel.debug,
                  logMessage: LogMessage(message: "pressed close button"));
              widget._vm.sqlRepository.sqlActions
                  .getProductList(true)
                  .then((value) {
                Navigator.of(context).pop(value);
              });
            },
          )
        ]);
  }
}
