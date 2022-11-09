import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:taesch/view_model/screen/shopping_list_screen_vm.dart';

/// shows the shopping list elements
class ShoppingListScreen extends StatefulWidget {
  final ShoppingListScreenVM _vm = ShoppingListScreenVM();

  ShoppingListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
        valueListenable: widget._vm.repository.shoppingListSize,
        builder: (context, value, child) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
            ),
            itemCount: value,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    setState(() {
                      widget
                          ._vm.repository.shoppingListItems.remove(widget._vm.repository.shoppingListItems[index]);
                    });
                    },
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Center(
                        child: Text(widget
                            ._vm.repository.shoppingListItems[index].title)),
                  ),
                ),
              );
            },
          );
        });
  }
}
