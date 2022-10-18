import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

/// shows the shopping list elements
class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key});

  @override
  State<StatefulWidget> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Shopping List"),
    );
  }
}
