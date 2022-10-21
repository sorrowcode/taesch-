import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

/// shows the shopping list elements
class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Shopping List"),
    );
  }
}
