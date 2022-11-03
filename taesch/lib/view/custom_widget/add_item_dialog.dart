import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
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
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    widget._vm.repository.shoppingListItems
                        .add(widget._vm.temp);
                    widget._vm.repository.shoppingListSize.value =
                        widget._vm.repository.shoppingListItems.length;
                  });
                  Navigator.of(context).pop();
                }
              }),
          TextButton(
            child: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ]);
  }
}
