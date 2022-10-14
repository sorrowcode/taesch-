import 'package:flutter/material.dart';
import 'package:taesch/pages/view_model/shopping_list_page_vm.dart';

/// this page contains all the shopping list elements
class ShoppingListPage extends StatefulWidget {
  ShoppingListPage({super.key, required this.title});

  final String title;
  final ShoppingListPageVM _vm = ShoppingListPageVM();

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget._vm.test();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
