import 'package:flutter/material.dart';
import 'package:taesch/model/error_case.dart';
import 'package:taesch/view_model/add_item_dialog_vm.dart';

class AddItemDialog extends StatefulWidget {
  final _vm = AddItemDialogVM();

  AddItemDialog({super.key});

  @override
  State<StatefulWidget> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Add Item to Shopping List'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                  validator: (value) {
                    return widget._vm.validateShoppingListItem(value)?.message;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Enter Item'))
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
              child: const Icon(Icons.check),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  setState(() {
                    widget._vm.repository.shoppingListItems
                        .add(widget._vm.temp);
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
